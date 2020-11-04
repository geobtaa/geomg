# frozen_string_literal: true

require 'uri'

# BulkAction
class BulkAction < ApplicationRecord
  # Validations
  validates :scope, :field_name, :field_value, presence: true

  before_save :collect_documents

  def run!
    # @TODO: guard this call for validation?

    # Queue Job
    BulkActionRunJob.perform_later(self)

    # Capture State
    # state_machine.transition_to!(:imported)
    # save
  end

  private

  def collect_documents
    uri = URI.parse(scope)
    self.documents = if uri.path.include?('fetch')
                       fetch_documents(uri)
                     else
                       api_documents(uri)
                     end
  end

  def fetch_documents(uri)
    qargs = Rack::Utils.parse_nested_query(uri.query)
    fetch_documents = Document.where(friendlier_id: qargs['ids'])
    self.documents = documents_json(fetch_documents)
  end

  def api_documents(uri)
    qargs = Rack::Utils.parse_nested_query(uri.query)
    api_documents = BlacklightApi.new(qargs['q'], qargs['f'], 1, '', 1_000_000)
    self.documents = documents_json(api_documents.load_all)
  end

  def documents_json(documents)
    documents.collect do |doc|
      { id: doc.friendlier_id, version: doc.current_version }
    end
  end
end
