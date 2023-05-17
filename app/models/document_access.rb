# frozen_string_literal: true

# DocumentAccess
class DocumentAccess < ApplicationRecord
  belongs_to :document, foreign_key: :friendlier_id, primary_key: :friendlier_id
  after_save :reindex_document

  # Validations
  validates :institution_code, :access_url, presence: true

  def self.import(file)
    logger.debug("CSV Import")
    CSV.foreach(file.path, headers: true) do |row|
      logger.debug("CSV Row: #{row.to_hash}")
      document_access = DocumentAccess.find_or_initialize_by(friendlier_id: row[0], institution_code: row[1])
      document_access.update(row.to_hash)
    end
  end

  def self.destroy_all(file)
    logger.debug("CSV Destroy")
    CSV.foreach(file.path, headers: true) do |row|
      logger.debug("CSV Row: #{row.to_hash}")
      DocumentAccess.destroy_by(id: row[0], friendlier_id: row[1])
    end
  end

  def to_csv
    attributes.values
  end

  def reindex_document
    document.save
  end
end
