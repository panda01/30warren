require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  test "should support a decimal number of bathrooms" do
    unit = Unit.new(number_of_bathrooms: 1.5)
    assert_equal 1.5, unit.number_of_bathrooms
  end
end
