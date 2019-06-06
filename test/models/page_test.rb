require 'test_helper'

class PageTest < ActiveSupport::TestCase

  test "should find next page" do
    first = pages(:one)
    second = pages(:two)

    first.update_column :position, 100
    second.update_column :position, 101

    assert_equal second, first.next
  end

  test "should detect if next page" do
    first = pages(:one)
    second = pages(:two)

    first.update_column :position, 100
    second.update_column :position, 101

    assert first.next?
  end

  test "should detect if no next page" do
    first = pages(:one)

    first.update_column :position, 100

    refute first.next?
  end

end
