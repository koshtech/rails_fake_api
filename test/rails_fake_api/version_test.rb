require 'test_helper'

class RailsFakeApi::VersionTest < ActiveSupport::TestCase
  test 'has a version number' do
    assert defined?(RailsFakeApi::VERSION), "RailsFakeApi::VERSION should be defined"
  end

  test 'the version number is 0.1.0' do
    assert_equal "0.1.0", RailsFakeApi::VERSION
  end

  test 'the version number is a string' do
    assert_kind_of String, RailsFakeApi::VERSION
  end
end
