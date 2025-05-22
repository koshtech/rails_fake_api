# frozen_string_literal: true

require_relative "rails_fake_api/version"
require_relative "rails_fake_api/engine"
require_relative "rails_fake_api/json_file_store"

module RailsFakeApi
  class Error < StandardError; end
end
