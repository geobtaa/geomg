# frozen_string_literal: true

require 'csv'

# ExportCsvService
class ExportCsvService
  def self.call(document_ids)
    ActionCable.server.broadcast('export_channel', { progress: 0 })

    total = document_ids.size
    count = 0
    slice_count = 100
    csv_file = []

    CSV.generate(headers: true) do |_csv|
      csv_file << Geomg.field_mappings_btaa.map { |k, _v| k.to_s }
      document_ids.each_slice(slice_count) do |doc_id|
        # Broadcast progress percentage
        count += slice_count
        progress = ((count.to_f / total) * 100).round
        progress = 100 if progress > 100

        ActionCable.server.broadcast('export_channel', { progress: progress })
        doc = Document.find(doc_id)

        csv_file << doc.to_csv
      end
    end

    csv_file
  end
end
