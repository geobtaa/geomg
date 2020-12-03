# frozen_string_literal: true

# Date Range Validation
#
# Allow: YYYY-YYYY, *-YYYY, YYYY-*
class Document
  # DateRangeValidator
  class DateRangeValidator < ActiveModel::Validator
    def validate(record)
      valid_date_ranges = true
      record.b1g_date_range_drsim.each do |date_range|
        if date_range[/[a-zA-Z]/]
          record.errors.add(:b1g_date_range_drsim, 'invalid date range present - only numbers allowed')
          valid_date_ranges = false
        elsif date_range[/\d{4}|\*-\d{4}|\*/]
          valid_date_ranges = true
        else
          record.errors.add(:b1g_date_range_drsim, 'invalid date range present')
          valid_date_ranges = false
        end
      end
      valid_date_ranges
    end
  end
end
