class DocumentDownload < ApplicationRecord
  belongs_to :document, foreign_key: :friendlier_id, primary_key: :friendlier_id
  after_save :reindex_document

  # Validations
  validates :label, :value, presence: true

  def self.import(file)
    logger.debug('CSV Import')
    CSV.foreach(file.path, headers: true) do |row|
      logger.debug("CSV Row: #{row.to_hash}")
      document_download = DocumentDownload.find_or_initialize_by(friendlier_id: row[0], label: row[1], value: row[2])
      document_download.update(row.to_hash)
    end
  end

  def reindex_document
    document.save
  end
end
