# frozen_string_literal: true

require 'json'
require 'pathname'

# ExportJob
class ExportJsonJob < ApplicationJob
  queue_as :default

  def perform(current_user, query_params, export_service)
    Rails.logger.debug("\n\n Background Job: ♞")
    Rails.logger.debug { "User: #{current_user.inspect}" }
    Rails.logger.debug { "Query: #{query_params.inspect}" }
    Rails.logger.debug { "Export Service: #{export_service.inspect}" }
    Rails.logger.debug("\n\n")

    # Test broadcast
    ActionCable.server.broadcast('export_channel', { data: 'Hello from Export JSON Job!' })

    # Query params into Doc ids
    document_ids = query_params[:ids] || crawl_query(query_params)

    # Rails.logger.debug("Document Ids: #{document_ids}")

    # Send progress
    documents = export_service.call(document_ids)

    # Write files into tempdir, zip together
    FileUtils.mkdir_p('ogm')

    Dir.mktmpdir do |dir|
      documents.each do |doc|
        # ===== Final Directory Structure =====
        # => Zip
        # ==> Provider
        # ===> Resource class (first)
        # ====> id.json

        Rails.logger.debug { "==== Query Format #{query_params[:format]} ====" }
        case query_params[:format]
        when 'json_btaa_aardvark'
          Rails.logger.debug { "==== Writing - #{doc.friendlier_id} - BTAA Aardvark ====" }
          @download_type = ' JSON - BTAA Aardvark'
          # File Path
          tree = Pathname("#{dir}/#{doc.schema_provider_s}/#{doc.gbl_resourceClass_sm.first}/#{doc.friendlier_id}.json")
          tree.dirname.mkpath

          json_output = DocumentsController.render(:_json_btaa_aardvark,
                                                   locals: { document: doc })

          json_obj = JSON.parse(json_output)
          Rails.logger.debug json_obj

          tree.write(JSON.pretty_generate(json_obj))
        when 'json_aardvark'
          Rails.logger.debug { "==== Writing - #{doc.friendlier_id} - GBL Aardvark ====" }
          @download_type = ' JSON - GBL Aardvark'
          # File Path
          tree = Pathname("#{dir}/#{doc.schema_provider_s}/#{doc.gbl_resourceClass_sm.first}/#{doc.friendlier_id}.json")
          tree.dirname.mkpath

          json_output = DocumentsController.render(:_json_aardvark,
                                                   locals: { document: doc })

          json_obj = JSON.parse(json_output)
          Rails.logger.debug json_obj

          tree.write(JSON.pretty_generate(json_obj))
        when 'json_gbl_v1'
          Rails.logger.debug { "==== Writing - #{doc.friendlier_id} - GBL v1 JSON ====" }
          @download_type = 'JSON - GBL v1'
          # File Path
          tree = Pathname("#{dir}/#{doc.schema_provider_s}/#{doc.gbl_resourceClass_sm.first}/#{doc.friendlier_id}.json")
          tree.dirname.mkpath

          json_output = DocumentsController.render(:_json_gbl_v1,
                                                   locals: { document: doc })

          json_obj = JSON.parse(json_output)
          Rails.logger.debug json_obj

          tree.write(JSON.pretty_generate(json_obj))
        end
      end

      # ===== Local debugging =====
      # Sanity check dir
      # Rails.logger.debug '==== Dir GLOB - START ===='
      # Rails.logger.debug Dir.glob("#{dir}/*")
      # Rails.logger.debug '==== Dir GLOB - END ===='

      # Zip dir and attach
      directory_to_zip = dir
      @zip_file = Rails.root.join('tmp', "export-json-#{Time.zone.today}-#{SecureRandom.hex(8)}.zip")
      zf = ZipFileGenerator.new(directory_to_zip, @zip_file)
      zf.write

      Rails.logger.debug { "File size: #{@zip_file.size}" }
    end

    # Create notification
    # Message: "Download Type|Row Count|Button Label"
    notification = ExportNotification.with(message: "#{@download_type}|#{ActionController::Base.helpers.number_with_delimiter(documents.size)} rows|ZIP")

    # Deliver notification
    notification.deliver(current_user)

    # Attach CSV file (can only attach after persisted)
    notification.record.file.attach(io: File.open(@zip_file), filename: "geomg-export-#{Time.zone.today}.zip",
                                    content_type: 'application/zip')

    Rails.logger.debug 'Notification File attached!'

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

  def crawl_query(query_params, doc_ids = [])
    logger.debug("\n\n CRAWL Query: #{query_params}")
    api_results = BlacklightApi.new(query_params)
    logger.debug("API Results: #{api_results.results.inspect}")

    doc_ids << api_results.results.pluck('id')

    unless api_results.meta['pages']['next_page'].nil?
      crawl_query(query_params.merge!({ page: api_results.meta['pages']['next_page'] }),
                  doc_ids)
    end

    doc_ids
  end
end
