require 'test_helper'

class ScaffoldControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get User" do
    get scaffold_controller_User_url
    assert_response :success
  end

end
