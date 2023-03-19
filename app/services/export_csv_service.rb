# frozen_string_literal: true

require "csv"

# ExportCsvService
class ExportCsvService
  def self.short_name
    "Documents"
  end

  def self.call(document_ids)
    ActionCable.server.broadcast("export_channel", {progress: 0})

    document_ids = document_ids.flatten
    total = document_ids.size
    count = 0
    slice_count = 100
    csv_file = []

    Rails.logger.debug { "\n\nExportCsvService: #{document_ids.inspect}\n\n" }

    CSV.generate(headers: true) do |_csv|
      Rails.logger.debug { "\n\n CSV Fields: #{Geomg.exportable_field_mappings.map { |k, _v| k.to_s }} \n\n" }

      csv_file << Geomg.exportable_field_mappings.map { |k, _v| k.to_s }
      document_ids.each_slice(slice_count) do |slice|
        # Broadcast progress percentage
        count += slice_count
        progress = ((count.to_f / total) * 100).round
        progress = 100 if progress > 100

        ActionCable.server.broadcast("export_channel", {progress: progress})
        slice.each do |doc_id|
          doc = Document.find_by(friendlier_id: doc_id)
          csv_file << doc.to_csv
        rescue NoMethodError
          Rails.logger.debug { "\n\nExport Failed: #{doc_id.inspect}\n\n" }
        end
      end
    end

    csv_file
  end
end
