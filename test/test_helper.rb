# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"
require "simplecov"
SimpleCov.start do
  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/test/" # for minitest
end

require_relative "../config/environment"
require "rails/test_help"

require "database_cleaner/active_record"
DatabaseCleaner.strategy = :truncation

require "minitest/rails"
require "minitest/reporters"
require "active_storage_validations/matchers"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

# DB needs to be clean and seeded
DatabaseCleaner.clean
Rails.application.load_seed

module ActiveSupport
  class TestCase
    extend ActiveStorageValidations::Matchers
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

    def setup
      DatabaseCleaner.start
    end

    def teardown
      DatabaseCleaner.clean
    end
  end
end
