require 'csv'

class Import < ApplicationRecord
  # Callbacks (keep at top)
  after_commit :set_csv_file_attributes, if: :persisted?
  after_commit :check_if_mapped, if: :persisted?

  # Associations
  has_one_attached :csv_file
  has_many :import_transitions, autosave: false
  has_many :mappings, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :mappings
  has_many :documents

  # States
  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: ImportTransition,
    initial_state: :created
  ]

  # Validations
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
    if mappings_valid? && self.state_machine.can_transition_to?(:mapped)
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
    data = CSV.parse(csv_file.download, headers: true)

    data.each do |doc|
      begin
        extract_hash = doc.to_h
        logger.debug("CSV Hash: #{extract_hash}")

        converted_data = transform_extract(extract_hash)
        converted_data = append_default_mappings(converted_data)
        converted_data = append_assumed_mappings(converted_data)
        converted_data = append_derived_mappings(converted_data)

        kithe_document = {
          title: converted_data['dc_title_s'],
          json_attributes: converted_data,
          friendlier_id: converted_data['layer_slug_s'],
          import_id: self.id,
        }

        # @TODO!!!!!!
        # - Make the actual Kithe Documents
        # - Do it in a loop, passing jobs to the background
        # - Add import report to view
        # - Kick off URI and SidecarImage jobs?

        document = Document.where(
          friendlier_id: converted_data['layer_slug_s']
        ).first_or_create.update(kithe_document)

        # @TODO - update returns boolean, need to clean up this logging data
        if document
          puts "Saved #{document.id}"
          self.import_log.merge!(
            { extract_hash['Identifier'] => 'Saved' }
          )
          next
        else
          puts "Failed - #{document.errors.inspect}"
          self.import_log.merge!(
            { extract_hash['Identifier'] => "Failed - #{document.errors.inspect.to_s}" }
          )
          next
        end
      rescue StandardError => error
        logger.debug("Error: #{error}")
        self.import_log.merge!(
          { extract_hash['Identifier'] => "Error - #{error.inspect.to_s}" }
        )
        next
      end
    end

    self.state_machine.transition_to!(:imported)
    self.save
  end

  private

  def transform_extract(extract_hash)
    transformed_data = {}
    self.mappings.each do |mapping|
      # logger.debug("Mapping: #{mapping.source_header} to #{mapping.destination_field}")

      # Handle repeatable dct_references_s entries
      if mapping.destination_field == 'dct_references_s'
        transformed_data[mapping.destination_field] ||= []
        transformed_data[mapping.destination_field] << {
           category: self.dct_references_mappings[mapping.source_header.to_sym],
           value: extract_hash[mapping.source_header]
          } unless extract_hash[mapping.source_header].nil?

      # Handle solr_geom transformation
      elsif mapping.destination_field == 'solr_geom'
        transformed_data[mapping.destination_field] = self.solr_geom_mapping(extract_hash[mapping.source_header])

      # Lastly, set existing values
      else
        transformed_data[mapping.destination_field] = extract_hash[mapping.source_header]
      end

      # Split delimited field values, if field has a value present
      if mapping.delimited?
        transformed_data[mapping.destination_field] = transformed_data[mapping.destination_field].present? ? transformed_data[mapping.destination_field].split('|') : ""
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

  # Merges derived value hashes into the data hash
  # Takes value from data hash, manipulates it, stores in new hash entry
  #
  # Ex. solr_geom is used to calc the b1g_centroid_ss value
  def append_derived_mappings(data_hash)
    self.derived_mappings.each do |mapping|
      mapping.each do |key, value|
        derived_mapping = {}

        args = {data_hash: data_hash.dup, field: value[:field]}
        derived_mapping[key] = self.send(value[:method], args)

        data_hash.merge!(derived_mapping.stringify_keys)
      end
    end

    data_hash
  end
end
