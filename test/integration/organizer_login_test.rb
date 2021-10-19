require "test_helper"

class OrganizerLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get organizerlogin_path
    assert_template 'organizersessions/new'
    post organizerlogin_path, params: { session: { name: "", password: "" } }
    assert_template 'organizersessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
