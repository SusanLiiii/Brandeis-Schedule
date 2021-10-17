require "test_helper"

class ParticipantsSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get participantsignup_path
    assert_no_difference 'Participant.count' do
      post participants_path, params: { participant: { name:  "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'participants/new'
  end

  test "valid signup information" do
    get participantsignup_path
    assert_difference 'Participant.count', 1 do
      post participants_path, params: { participant: { name:  "Example User", email: "user@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'participants/show'
  end
end
