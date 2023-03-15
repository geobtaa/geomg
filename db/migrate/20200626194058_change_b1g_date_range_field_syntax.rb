# frozen_string_literal: true

class ChangeB1gDateRangeFieldSyntax < ActiveRecord::Migration[6.0]
  def change
    begin
      Document.all.each do |doc|
        date_ranges = []
        doc.b1g_date_range_drsim.each do |date_range|
          next unless date_range.include?('TO')

          start_d = date_range[1..4]
          end_d   = date_range[9..12]
          date_ranges << "#{start_d}-#{end_d}"
        end
        doc.update(b1g_date_range_drsim: date_ranges)
      end
    rescue
      # No harm, no foul
    end
  end
end
