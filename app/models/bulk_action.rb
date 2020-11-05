# frozen_string_literal: true

require 'uri'

# BulkAction
class BulkAction < ApplicationRecord
  # Callbacks
  after_create_commit :collect_documents

  # Associations
  has_many :documents, class_name: 'BulkActionDocument', autosave: false, dependent: :destroy

  has_many :bulk_action_transitions, autosave: false, dependent: :destroy

  # Validations
  validates :scope, :field_name, :field_value, presence: true

  # States
  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: BulkActionTransition,
    initial_state: :created
  ]

  def state_machine
    @state_machine ||= BulkActionStateMachine.new(self, transition_class: BulkActionTransition)
  end

  def run!
    # @TODO: guard this call for validation?

    # Queue Job
    BulkActionRunJob.perform_later(self)

    # Capture State
    # state_machine.transition_to!(:imported)
    # save
  end

  def check_run_state
    return if state_machine.current_state == 'complete'

    state_machine.transition_to!(:complete) if documents.in_state(:queued).blank?
  end

  private

  def collect_documents
    uri = URI.parse(scope)
    if uri.path.include?('fetch')
      fetch_documents(uri)
    else
      api_documents(uri)
    end
  end

  def fetch_documents(uri)
    qargs = Rack::Utils.parse_nested_query(uri.query)
    fetch_documents = Document.where(friendlier_id: qargs['ids'])
    create_documents(fetch_documents)
  end

  def api_documents(uri)
    qargs = Rack::Utils.parse_nested_query(uri.query)
    api_documents = BlacklightApi.new(qargs['q'], qargs['f'], 1, '', 1_000_000)
    create_documents(api_documents.load_all)
  end

  def create_documents(documents)
    documents.collect do |doc|
      BulkActionDocument.create(
        friendlier_id: doc.friendlier_id,
        version: doc.current_version,
        bulk_action_id: id
      )
    end
  end
end
