require 'test_helper'

class ResidencesControllerTest < ActionController::TestCase
  test "should get show" do
    pages(:one).update_column 'slug', 'residences'
    get :show
    assert_response :success
  end

end
