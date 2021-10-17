require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  def setup
    @participant = Participant.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @participant.valid?
  end

  test "name should be present" do
    @participant.name = "     "
    assert_not @participant.valid?
  end

  test "email should be present" do
    @participant.email = "     "
    assert_not @participant.valid?
  end

  test "name should not be too long" do
    @participant.name = "a" * 51
    assert_not @participant.valid?
  end

  test "email should not be too long" do
    @participant.email = "a" * 244 + "@example.com"
    assert_not @participant.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @participant.email = valid_address
      assert @participant.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @participant.email = invalid_address
      assert_not @participant.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @participant.dup
    @participant.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @participant.password = @participant.password_confirmation = " " * 6
    assert_not @participant.valid?
  end

  test "password should have a minimum length" do
    @participant.password = @participant.password_confirmation = "a" * 5
    assert_not @participant.valid?
  end
end
