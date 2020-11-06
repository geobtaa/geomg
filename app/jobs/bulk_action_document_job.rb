# frozen_string_literal: true

# BulkActionDocumentJob
class BulkActionDocumentJob < ApplicationJob
  queue_as :default

  def perform(action, doc, field_name, field_value)
    case action
    when :update_publication_status
      document = Document.find_by!(friendlier_id: doc.friendlier_id)

      logger.debug("Update PubStatus - #{document.friendlier_id} => #{field_value}")

      if document.update!(publication_state: field_value.to_sym)
        doc.state_machine.transition_to!(:success)
      else
        doc.state_machine.transition_to!(:failed)
      end
    when :update_delete
      document = Document.find_by!(friendlier_id: doc.friendlier_id)

      logger.debug("Update Delete - #{document.friendlier_id} => #{field_value}")

      if document.destroy
        doc.state_machine.transition_to!(:success)
      else
        doc.state_machine.transition_to!(:failed)
      end

    # @TODO: Field Level changes
    else
      logger.debug("@TODO - #{field_name} => #{field_value}")
    end
  end
end
