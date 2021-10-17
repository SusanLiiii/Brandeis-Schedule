require "test_helper"

class OrganizerTest < ActiveSupport::TestCase
  def setup
    @organizer = Organizer.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @organizer.valid?
  end

  test "name should be present" do
    @organizer.name = "     "
    assert_not @organizer.valid?
  end

  test "email should be present" do
    @organizer.email = "     "
    assert_not @organizer.valid?
  end

  test "name should not be too long" do
    @organizer.name = "a" * 51
    assert_not @organizer.valid?
  end

  test "email should not be too long" do
    @organizer.email = "a" * 244 + "@example.com"
    assert_not @organizer.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @organizer.email = valid_address
      assert @organizer.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @organizer.email = invalid_address
      assert_not @organizer.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @organizer.dup
    @organizer.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @organizer.password = @organizer.password_confirmation = " " * 6
    assert_not @organizer.valid?
  end

  test "password should have a minimum length" do
    @organizer.password = @organizer.password_confirmation = "a" * 5
    assert_not @organizer.valid?
  end
end
