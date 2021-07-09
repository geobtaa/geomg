# frozen_string_literal: true

require 'csv'

# ExportJob
class ExportJob < ApplicationJob
  queue_as :default

  def perform(current_user, document_ids, export_service)
    logger.debug("\n\n Background Job: ♞")
    logger.debug("User: #{current_user.inspect}")
    logger.debug("Doc Ids: #{document_ids.inspect}")
    logger.debug("Export Service: #{export_service.inspect}")
    logger.debug("\n\n")

    # Test broadcast
    ActionCable.server.broadcast('export_channel', { data: 'Hello from Export Job!' })

    # Send progress
    file_content = export_service.call(document_ids)

    # Write into tempfile
    @tempfile = Tempfile.new(["export-#{Time.zone.today}", '.csv']).tap do |file|
      CSV.open(file, 'wb') do |csv|
        file_content.each do |row|
          csv << row
        end
      end
    end

    # Create notification
    notification = ExportNotification.with(message: "#{ActionController::Base.helpers.number_with_delimiter(file_content.size)} rows")

    # Deliver notification
    notification.deliver(current_user)

    # Attach CSV file (can only attach after persisted)
    notification.record.file.attach(io: @tempfile, filename: "geomg-export-#{Time.zone.today}.csv", content_type: 'text/csv')

    # Update UI
    ActionCable.server.broadcast('export_channel', {
      data: 'Notification ready!',
      actions: [
        {
          method: 'RefreshNotifications',
          payload: current_user.notifications.unread.count
        }
      ]
    })
  end
end
