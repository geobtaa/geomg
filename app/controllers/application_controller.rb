# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :set_action_cable_identifier

  private

  def set_action_cable_identifier
    cookies.encrypted[:user_id] = current_user&.id
  end
end
