# frozen_string_literal: true

require "csv"

# ExportJob
class ExportJob < ApplicationJob
  queue_as :default

  def perform(current_user, query_params, export_service)
    logger.debug("\n\n Background Job: ♞")
    logger.debug("User: #{current_user.inspect}")
    logger.debug("Query: #{query_params.inspect}")
    logger.debug("Export Service: #{export_service.inspect}")
    logger.debug("\n\n")

    # Test broadcast
    ActionCable.server.broadcast("export_channel", {data: "Hello from Export Job!"})

    # Query params into Doc ids
    document_ids = query_params[:ids] || crawl_query(query_params)

    logger.debug("Document Ids: #{document_ids}")

    # Send progress
    file_content = export_service.call(document_ids)

    # Write into tempfile
    @tempfile = Tempfile.new(["export-#{Time.zone.today}", ".csv"]).tap do |file|
      CSV.open(file, "wb") do |csv|
        file_content.each do |row|
          csv << row
        end
      end
    end

    # Create notification
    # Message: "Download Type|Row Count|Button Label"
    notification = ExportNotification.with(message: "CSV (#{export_service.short_name})|#{ActionController::Base.helpers.number_with_delimiter(file_content.size - 1)} rows|CSV")

    # Deliver notification
    notification.deliver(current_user)

    # Attach CSV file (can only attach after persisted)
    notification.record.file.attach(io: @tempfile, filename: "geomg-export-#{Time.zone.today}.csv", content_type: "text/csv")

    # Update UI
    ActionCable.server.broadcast("export_channel", {
      data: "Notification ready!",
      actions: [
        {
          method: "RefreshNotifications",
          payload: current_user.notifications.unread.count
        }
      ]
    })
  end

  def crawl_query(query_params, doc_ids = [])
    logger.debug("\n\n CRAWL Query: #{query_params}")
    api_results = BlacklightApiIds.new(query_params)
    logger.debug("API Results: #{api_results.results.inspect}")

    doc_ids << api_results.results.pluck("id")

    unless api_results.meta["pages"]["next_page"].nil?
      crawl_query(query_params.merge!({page: api_results.meta["pages"]["next_page"]}),
        doc_ids)
    end

    doc_ids
  end
end
