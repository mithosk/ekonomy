class UserServices::AuthenticateUserTest < Minitest::Test
  def setup
    @user_class_mock = Minitest::Mock.new
    @user_instance_mock = Minitest::Mock.new

    @faked_user_id = SecureRandom.random_number
    @faked_username = SecureRandom.uuid
    @faked_password = SecureRandom.uuid
    @faked_full_name = SecureRandom.uuid
  end

  def test_unit_should_get_user_by_username
    @user_instance_mock.expect(:authenticate, @user_instance_mock, [ Object ])
    @user_instance_mock.expect(:id, @faked_user_id)
    @user_class_mock.expect(:find_by, @user_instance_mock, [ { username: @faked_username } ])

    User.stub(:find_by, ->(params) { @user_class_mock.find_by(params) }) do
      UserServices::AuthenticateUser.call(username: @faked_username, password: @faked_password)
    end

    @user_class_mock.verify
    @user_instance_mock.verify
  end

  def test_unit_should_verify_password
    @user_instance_mock.expect(:authenticate, @user_instance_mock, [ @faked_password ])
    @user_instance_mock.expect(:id, @faked_user_id)

    User.stub(:find_by, @user_instance_mock) do
      UserServices::AuthenticateUser.call(username: @faked_username, password: @faked_password)
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_user_id_when_authentication_succeeds
    @user_instance_mock.expect(:authenticate, @user_instance_mock, [ Object ])
    @user_instance_mock.expect(:id, @faked_user_id)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::AuthenticateUser.call(username: @faked_username, password: @faked_password)
      assert_equal({ user_id: @faked_user_id }, result)
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_nil_when_user_does_not_exist
    User.stub(:find_by, nil) do
      result = UserServices::AuthenticateUser.call(username: @faked_username, password: @faked_password)
      assert_equal({ user_id: nil }, result)
    end
  end

  def test_unit_should_return_nil_when_password_is_wrong
    @user_instance_mock.expect(:authenticate, false, [ Object ])

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::AuthenticateUser.call(username: @faked_username, password: @faked_password)
      assert_equal({ user_id: nil }, result)
    end

    @user_instance_mock.verify
  end

  def test_integration_should_return_user_id_when_authentication_succeeds
    user = User.new(
      username: @faked_username,
      password: @faked_password,
      password_confirmation: @faked_password,
      full_name: @faked_full_name,
      role: "ADMIN",
      dashboard: true,
      detection: true,
      balancing: true,
      expense: true,
      category: true
    )

    user.save

    result = UserServices::AuthenticateUser.call(username: @faked_username, password: @faked_password)
    assert_equal({ user_id: user.id }, result)
  end

  def test_integration_should_return_nil_when_user_does_not_exist
    result = UserServices::AuthenticateUser.call(username: @faked_username, password: @faked_password)
    assert_equal({ user_id: nil }, result)
  end

  def test_integration_should_return_nil_when_password_is_wrong
    user = User.new(
      username: @faked_username,
      password: @faked_password,
      password_confirmation: @faked_password,
      full_name: @faked_full_name,
      role: "OPERATOR",
      dashboard: false,
      detection: false,
      balancing: false,
      expense: false,
      category: false
    )

    user.save

    result = UserServices::AuthenticateUser.call(username: @faked_username, password: SecureRandom.uuid)
    assert_equal({ user_id: nil }, result)
  end
end
