ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  def sign_in_as(user_or_key)
    u = user_or_key
    u = users(user_or_key) if u.is_a? Symbol
    sign_in(u)
  end

  def sign_out_as(user_or_key)
    u = user_or_key
    u = users(user_or_key) if u.is_a? Symbol
    sign_out u
  end

  # Add more helper methods to be used by all tests here...
end
