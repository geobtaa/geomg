# frozen_string_literal: true

# Date Range Validation
#
# Allow: YYYY-YYYY, *-YYYY, YYYY-*, Start YYYY == End YYYY
# Disallow: YYYX-YYYY, YYYY-, 2000-1999, YYYY-YYYY?
class Document
  # DateRangeValidator
  class DateRangeValidator < ActiveModel::Validator
    def validate(record)
      valid_date_ranges = true
      record.send(GEOMG.FIELDS.B1G_DATE_RANGE).each do |date_range|
        # Empty is fine
        if date_range.blank?
          valid_date_ranges = true
          return valid_date_ranges
        end

        # Must split into two via '-'
        if date_range.split('-').size != 2
          record.errors.add(GEOMG.FIELDS.B1G_DATE_RANGE, 'invalid date range present - missing YYYY-YYYY value')
          valid_date_ranges = false
          return valid_date_ranges
        end

        start_date,end_date = date_range.split('-')

        unless valid_yyyy(start_date)
          record.errors.add(GEOMG.FIELDS.B1G_DATE_RANGE, 'invalid start date - bad YYYY-YYYY value, only integers or the wildcard \'*\' allowed')
          valid_date_ranges = false
        end

        unless valid_yyyy(end_date)
          record.errors.add(GEOMG.FIELDS.B1G_DATE_RANGE, 'invalid end date - bad YYYY-YYYY value, only integers or the wildcard \'*\' allowed')
          valid_date_ranges = false
        end

        # Allow only 1 wildcard
        if start_date == '*' && end_date == '*'
          record.errors.add(GEOMG.FIELDS.B1G_DATE_RANGE, 'invalid only one wildcard can be used')
          valid_date_ranges = false
        end

        # Avoid 1996-1946
        if start_date[/\d+/] && end_date[/\d+/]
          unless start_date.to_i <= end_date.to_i
            record.errors.add(GEOMG.FIELDS.B1G_DATE_RANGE, 'invalid start date must be less than the end date')
            valid_date_ranges = false
          end
        end
      end
      valid_date_ranges
    end

    def valid_yyyy(date)
      if date[/\D/]
        return false unless date == '*'
      else
        return true
      end
    end
  end
end
