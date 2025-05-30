# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
require "rails/test_help"
require "minitest/autorun"
require "mocha/minitest"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
end

class ActionDispatch::IntegrationTest
end
