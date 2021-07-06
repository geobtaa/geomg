# frozen_string_literal: true

require 'csv'

# ExportJob
class ExportJob < ApplicationJob
  queue_as :default

  def perform(user, document_ids, export_service)
    logger.debug("\n\n Background Job: ♞")
    logger.debug("User: #{user.inspect}")
    logger.debug("Doc Ids: #{document_ids.inspect}")
    logger.debug("Export Service: #{export_service.inspect}")
    logger.debug("\n\n")

    # Test broadcast
    ActionCable.server.broadcast('export_channel', { data: 'Hello from Export Job!' })

    # Send progress - @TODO
    file_content = export_service.call(document_ids)

    # Send file
    ActionCable.server.broadcast('export_channel', generate_csv(file_content))
  end

  def generate_csv(file)
    {
      csv_file: {
        file_name: "documents-#{Time.zone.today}.csv",
        content: file
      }
    }
  end
end
