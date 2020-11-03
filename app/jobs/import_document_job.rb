# frozen_string_literal: true

# ImportDocumentJob class
class ImportDocumentJob < ApplicationJob
  queue_as :default

  def perform(import_document)
    document = Document.where(
      friendlier_id: import_document.friendlier_id
    ).first_or_create

    if document.update!(import_document.to_hash)
      import_document.state_machine.transition_to!(:success)
    else
      import_document.state_machine.transition_to!(:failed, "Failed - #{document.errors.inspect}")
    end
  rescue StandardError => e
    logger.debug("Error: #{e}")
    import_document.state_machine.transition_to!(:failed, "Error - #{e.inspect}")
  end
end
