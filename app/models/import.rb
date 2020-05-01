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

  def all_mapping_keys
    database = self.mappings.collect{ |c| c.destination_field }
    default = self.default_mappings.collect{ |c| c.keys }
    assumed = self.assumed_mappings.collect{ |c| c.values }

    mappings = (database + default + assumed).flatten
    mappings.map(&:to_s)
  end

  def mappings_valid?
    (GEOMG_SCHEMA[:required] - all_mapping_keys.uniq).empty?
  end

  def import!
    # @TODO: guard this call, unless mappings_valid?
    begin
      data = CSV.parse(csv_file.download, headers: true)
      extract_hash = data.first.to_h
      logger.debug("Extract Hash: #{extract_hash}")

      converted_data = transform_extract(extract_hash)
      converted_data = append_default_mappings(converted_data)
      converted_data = append_assumed_mappings(converted_data)
    rescue StandardError => error
      logger.console("Error: #{error}")
    end
  end

  private

  def transform_extract(extract_hash)
    transformed_data = {}
    self.mappings.each do |mapping|
      logger.debug("Mapping: #{mapping.source_header} to #{mapping.destination_field}")

      # Handle repeatable dct_references_s mapping
      if mapping.destination_field == 'dct_references_s'
        transformed_data[mapping.destination_field] ||= []
        transformed_data[mapping.destination_field] << {
           self.dct_references_mappings[mapping.source_header.to_sym] => extract_hash[mapping.source_header]
          } unless extract_hash[mapping.source_header].nil?
      # Otherwise just set the value
      else
        transformed_data[mapping.destination_field] = extract_hash[mapping.source_header]
      end

      if mapping.delimited?
        transformed_data[mapping.destination_field] = transformed_data[mapping.destination_field].split('|')
      end
    end

    transformed_data
  end

  # Merges an array of hashes into the data hash
  def append_default_mappings(data_hash)
    self.default_mappings.each do |mapping|
      data_hash.merge!(mapping.stringify_keys)
    end

    data_hash
  end

  # Merges copied value hashes into the data hash
  def append_assumed_mappings(data_hash)
    self.assumed_mappings.each do |mapping|
      mapping.each do |key, value|
        assumed_mapping = {}
        assumed_mapping[value] = data_hash[key.to_s]
        data_hash.merge!(assumed_mapping)
      end
    end

    data_hash
  end
end
