# frozen_string_literal: true

require "test_helper"

class RailsFakeApiTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::RailsFakeApi.const_defined?(:VERSION)
    end
  end

  test "something useful" do
    assert_equal("expected", "actual")
  end
end
