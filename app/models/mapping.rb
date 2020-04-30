class Mapping < ApplicationRecord
  belongs_to :import

  # Validations
  validates :source_header, presence: true
  validates :destination_field, presence: true
end
