require "test_helper"

class ParticipantLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get participantlogin_path
    assert_template 'participantsessions/new'
    post participantlogin_path, params: { session: { email: "", password: "" } }
    assert_template 'participantsessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
