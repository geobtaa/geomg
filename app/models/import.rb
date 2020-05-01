require 'csv'

class Import < ApplicationRecord
  after_commit :set_csv_file_attributes, if: :persisted?
  after_commit :check_if_mapped, if: :persisted?

  has_one_attached :csv_file
  has_many :import_transitions, autosave: false
  has_many :mappings, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :mappings

  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: ImportTransition,
    initial_state: :created
  ]
  validates :type, presence: true
  validates :csv_file, attached: true, content_type: { in: 'text/csv', message: 'is not a CSV file' }

  def state_machine
    @state_machine ||= ImportStateMachine.new(self, transition_class: ImportTransition)
  end

  def set_csv_file_attributes
    content_type = csv_file.content_type.to_s
    filename = csv_file.filename.to_s
    extension = csv_file.filename.extension.to_s

    parsed = CSV.parse(csv_file.download)

    self.update_columns(
      headers: parsed[0],
      row_count: parsed.size - 1,
      content_type: content_type,
      filename: filename,
      extension: extension
    )
  end

  def check_if_mapped
    if mappings_valid?
      self.state_machine.transition_to!(:mapped)
    end
  end

  def all_mappings
    database = self.mappings.collect{ |c| c.destination_field }
    default = self.default_mappings.collect{ |c| c.keys }
    assumed = self.assumed_mappings.collect{ |c| c.values }

    mappings = (database + default + assumed).flatten
    mappings.map(&:to_s)
  end

  def mappings_valid?
    (GEOMG_SCHEMA[:required] - all_mappings.uniq).empty?
  end
end
