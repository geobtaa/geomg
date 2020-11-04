# frozen_string_literal: true

# ImportRunJob class
class ImportRunJob < ApplicationJob
  queue_as :default

  def perform(import)
    data = CSV.parse(import.csv_file.download.force_encoding('UTF-8'), headers: true)

    data.each do |doc|
      extract_hash = doc.to_h

      converted_data = import.convert_data(extract_hash)

      kithe_document = {
        title: converted_data['dc_title_s'],
        json_attributes: converted_data,
        friendlier_id: converted_data['layer_slug_s'],
        import_id: import.id
      }

      # Capture document
      import_document = ImportDocument.create(kithe_document)

      # Queue import background job
      ImportDocumentJob.perform_later(import_document)

      # @TODO
      # - Possibly kick off URI and SidecarImage jobs
    end
  end
end
