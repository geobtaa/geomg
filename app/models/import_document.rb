# frozen_string_literal: true

# ImportDocument class
class ImportDocument < ApplicationRecord
  has_many :import_document_transitions, autosave: false, dependent: :destroy

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
      json_attributes: nullify_empty_json_attributes,
      import_id: import_id
    }
  end

  def nullify_empty_json_attributes
    clean_hash = {}

    json_attributes.each do |key, value|
      clean_hash[key] = value.present? ? value : nil
    end

    clean_hash
  end
end
