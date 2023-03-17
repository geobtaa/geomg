# frozen_string_literal: true

module ApplicationCable
  # Connect!
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    # check for authenticated user via devise
    def find_verified_user
      verified_user = env["warden"].user

      verified_user || reject_unauthorized_connection
    end
  end
end
