class Bookmark < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :document, polymorphic: true

  validates :user_id, presence: true

  def document_type
    value = super if defined?(super)
    value &&= value.constantize
    value || default_document_type
  end

  def default_document_type
    SolrDocument
  end
end
