# frozen_string_literal: true

# ImportDocumentJob class
class ImportDocumentJob < ApplicationJob
  queue_as :default

  def perform(import_document)
    # @TODO: Check for friendlier_id or raise error
    document = Document.where(
      friendlier_id: import_document.friendlier_id
    ).first_or_create

    # Set the geom
    document.set_geometry

    if document.update(import_document.to_hash)
      import_document.state_machine.transition_to!(:success)
    else
      import_document.state_machine.transition_to!(:failed, "Failed - #{document.errors.inspect}")
    end
  rescue => e
    logger.debug("Error: #{e}")
    import_document.state_machine.transition_to!(:failed, "Error - #{e.inspect}")
  end
end
