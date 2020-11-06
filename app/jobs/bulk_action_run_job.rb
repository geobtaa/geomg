# frozen_string_literal: true

# BulkActionRunJob
class BulkActionRunJob < ApplicationJob
  queue_as :default

  def perform(bulk_action)
    action = case bulk_action.field_name
             when 'Publication State'
               logger.debug('BulkAction: Update Publication Status')
               :update_publication_status
             else
               :update_field_value
             end

    bulk_action.documents.each do |doc|
      BulkActionDocumentJob.perform_later(action, doc, bulk_action.field_name, bulk_action.field_value)
      doc.state_machine.transition_to!(:queued)
    end
  end
end
