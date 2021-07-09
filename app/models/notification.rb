# frozen_string_literal: true

class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  has_one_attached :file
end
