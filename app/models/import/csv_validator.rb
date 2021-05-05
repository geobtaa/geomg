# frozen_string_literal: true

# CSV Validator
#
class Import
  # CsvValidator
  class CsvValidator < ActiveModel::Validator
    def validate(record)
      valid_csv = true
      csv_file = record.csv_file

      valid_csv
    end
  end
end
