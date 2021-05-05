# frozen_string_literal: true

require 'csv'

# CSV Header Validation
class Import
  # CsvHeaderValidator
  class CsvHeaderValidator < ActiveModel::Validator
    def validate(record)
      valid_csv_header = true
      unless valid_csv_header?(record.csv_file)
        valid_csv_header = false
        record.errors.add(:csv_file, 'Missing a required CSV header. Title, Resource Class, Access Rights, and ID are required.')
      end

      valid_csv_header
    end

    def valid_csv_header?(csv_file)
      headers = CSV.parse(csv_file.download)[0]
      if (['Title', 'Resource Class', 'Access Rights', 'ID'] - headers).empty?
        true
      else
        false
      end
    end
  end
end
