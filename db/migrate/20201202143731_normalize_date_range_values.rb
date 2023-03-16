class NormalizeDateRangeValues < ActiveRecord::Migration[6.0]
  def change
    docs = Document.all
    docs.each do |doc|
      date_ranges = []
      doc.b1g_date_range_drsim.each do |date_range|
        if date_range.include?("TO")
          fixed_range = date_range.scan(/\d+/).join("-")
          date_ranges << fixed_range
        else
          date_ranges << date_range
        end
      end

      doc.b1g_date_range_drsim = date_ranges
      begin
        doc.save
        puts "Saved - Date Range Normalized - Doc  #{doc.friendlier_id}"
      rescue
        puts "Failed - Date Range Normalized - Doc #{doc.friendlier_id}"
      end
    end
  end
end
