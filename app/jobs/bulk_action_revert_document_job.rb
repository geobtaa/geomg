class BulkActionRevertDocumentJob < ApplicationJob
  queue_as :default

  def perform(action, doc)
    case action
    when :revert_publication_status
      document = Document.find_by!(friendlier_id: doc.friendlier_id)

      logger.debug("Revert PubStatus - #{document.friendlier_id}")

      versions = document.versions
      document = versions[doc.version].reify
      document.skip_callbacks = true

      if document.save
        doc.state_machine.transition_to!(:success)
      else
        doc.state_machine.transition_to!(:failed)
      end
    when :revert_delete
      document = Document.new(id: doc.document_id)

      logger.debug("Revert Delete - #{document.id}")

      versions = document.versions
      document = versions.last.reify
      document.skip_callbacks = true

      if document.save
        doc.state_machine.transition_to!(:success)
      else
        doc.state_machine.transition_to!(:failed)
      end
    else :revert_field_value
      logger.debug("@TODO - #{field_name} => #{field_value}")
    end

  end
end
