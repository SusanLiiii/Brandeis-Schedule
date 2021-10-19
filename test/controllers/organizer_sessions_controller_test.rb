require "test_helper"

class OrganizerSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get organizerlogin_path
    assert_response :success
  end
end
