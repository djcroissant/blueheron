require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Example", last_name: "User",
                     email: "user@example.com",
                     password: "Foobar11", password_confirmation: "Foobar11")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = "   "
    assert_not @user.valid?
  end

  test "last ame should be present" do
    @user.last_name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.first_name= "a" * 51
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.last_name= "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email= "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..baz]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be invalid"
    end
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = @user.email = "MixEd@CasE.coM"
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be 8 characters or more" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated listings should be destroyed" do
    @user.save
    @user.listings.create!(name: "King Salmon", quantity: 200,
                           price: 13.50, date_caught: Date.today)
    assert_difference 'Listing.count', -1 do
      @user.destroy
    end
  end
end
