# frozen_string_literal: true

# DocumentAccess
class DocumentAccess < ApplicationRecord
  belongs_to :document, foreign_key: :friendlier_id, primary_key: :friendlier_id

  # Validations
  validates :friendlier_id, :institution_code, :access_url, presence: true

  def self.import(_document, file)
    CSV.foreach(file.path, headers: true) do |row|
      DocumentAccess.create! row.to_hash
    end
  end
end
