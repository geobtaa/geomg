ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  def log_in(user)
    if integration_test?
      # use warden helper
      login_as(user, scope: user)
    else # controller_test, model_test
      # user devise helper
      sign_in(user)
    end
  end

  # Add more helper methods to be used by all tests here...
end
