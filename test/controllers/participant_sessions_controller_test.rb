require "test_helper"

class ParticipantSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get participantlogin_path
    assert_response :success
  end
end
