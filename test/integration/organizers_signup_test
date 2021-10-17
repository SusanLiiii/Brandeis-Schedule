require "test_helper"

class OrganizersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get organizersignup_path
    assert_no_difference 'Organizer.count' do
      post organizers_path, params: { organizer: { name:  "", email: "user@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'organizers/new'
  end

  test "valid signup information" do
    get organizersignup_path
    assert_difference 'Organizer.count', 1 do
      post organizers_path, params: { organizer: { name:  "Example User", email: "user@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'organizers/show'
  end
end
