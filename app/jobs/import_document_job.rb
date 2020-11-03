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
  rescue StandardError => error
    logger.debug("Error: #{error}")
    import_document.state_machine.transition_to!(:failed, "Error - #{error.inspect}")
  end
end
