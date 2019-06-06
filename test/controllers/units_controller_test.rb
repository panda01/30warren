require 'test_helper'

class UnitsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: units(:one).id
    assert_response :success
  end

end
