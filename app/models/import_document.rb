class ImportDocument < ApplicationRecord
  has_many :import_document_transitions, autosave: false

  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: ImportDocumentTransition,
    initial_state: :queued
  ]

  def state_machine
    @state_machine ||= ImportDocumentStateMachine.new(self, transition_class: ImportDocumentTransition)
  end

  def to_hash
    {
      friendlier_id: friendlier_id,
      title: title,
      json_attributes: json_attributes,
      import_id: import_id
    }
  end
end
