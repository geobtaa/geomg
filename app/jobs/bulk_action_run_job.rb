# frozen_string_literal: true

# BulkActionRunJob
class BulkActionRunJob < ApplicationJob
  queue_as :default

  def perform(bulk_action)
    action = case bulk_action.field_name
    when "Publication State"
      logger.debug("BulkAction: Update Publication Status")
      :update_publication_status
    when "Delete"
      logger.debug("BulkAction: Delete")
      :update_delete
    else
      :update_field_value
    end

    bulk_action.documents.each do |doc|
      BulkActionRunDocumentJob.perform_later(action, doc, bulk_action.field_name, bulk_action.field_value)
      doc.state_machine.transition_to!(:queued)
    end

    # Capture State
    bulk_action.state_machine.transition_to!(:queued)
  end
end
