class UserServices::DeleteUserTest < Minitest::Test
  def setup
    @user_instance_mock = Minitest::Mock.new
    @user_errors_mock = Minitest::Mock.new

    @faked_user_id = SecureRandom.random_number
    @faked_username = SecureRandom.uuid
    @faked_password = SecureRandom.uuid
    @faked_full_name = SecureRandom.uuid
    @faked_error = SecureRandom.uuid
  end

  def test_unit_should_return_error_when_user_is_not_admin
    @user_instance_mock.expect(:role, "OPERATOR")

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::DeleteUser.call(
        user_id: @faked_user_id,
        session_user_id: SecureRandom.random_number
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error_when_user_is_self
    @user_instance_mock.expect(:role, "ADMIN")

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::DeleteUser.call(
        user_id: @faked_user_id,
        session_user_id: @faked_user_id
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_destroy_user_without_error
    @user_instance_mock.expect(:role, "ADMIN")
    @user_instance_mock.expect(:destroy, true)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::DeleteUser.call(
        user_id: @faked_user_id,
        session_user_id: SecureRandom.random_number
      )

      assert_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_destroy_user_with_error
    @user_instance_mock.expect(:role, "ADMIN")
    @user_instance_mock.expect(:destroy, false)
    @user_instance_mock.expect(:errors, @user_errors_mock)
    @user_errors_mock.expect(:full_messages, [ @faked_error ])

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::DeleteUser.call(
        user_id: @faked_user_id,
        session_user_id: SecureRandom.random_number
      )

      assert_equal result[:error], @faked_error
    end

    @user_instance_mock.verify
    @user_errors_mock.verify
  end

  def test_integration_should_destroy_user
    to_delete_user = User.new(
      username: @faked_username,
      password: @faked_password,
      password_confirmation: @faked_password,
      full_name: @faked_full_name,
      role: "OPERATOR",
      dashboard: true,
      detection: true,
      balancing: true,
      expense: true,
      category: true
    )

    session_user = User.new(
      username: SecureRandom.uuid,
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

    to_delete_user.save
    session_user.save

    UserServices::DeleteUser.call(
      user_id: to_delete_user.id,
      session_user_id: session_user.id
    )

    assert_nil User.find_by(id: to_delete_user.id)
  end
end
