class UserServices::CreateUserTest < Minitest::Test
  def setup
    @user_class_mock = Minitest::Mock.new
    @user_instance_mock = Minitest::Mock.new
    @user_errors_mock = Minitest::Mock.new

    @faked_username = SecureRandom.uuid
    @faked_password = SecureRandom.uuid
    @faked_password_confirmation = SecureRandom.uuid
    @faked_full_name = SecureRandom.uuid
    @faked_user_id = SecureRandom.random_number
    @faked_error = SecureRandom.uuid
  end

  def test_unit_should_create_admin_user
    expected_new_params = {
      username: @faked_username,
      password: @faked_password,
      password_confirmation: @faked_password_confirmation,
      full_name: @faked_full_name,
      role: "ADMIN",
      dashboard: true,
      detection: true,
      balancing: true,
      expense: true,
      category: true
    }

    @user_class_mock.expect(:new, @user_instance_mock, [ expected_new_params ])
    @user_instance_mock.expect(:save, true)
    @user_instance_mock.expect(:id, @faked_user_id)

    User.stub(:count, 0) do
      User.stub(:new, ->(params) { @user_class_mock.new(params) }) do
        UserServices::CreateUser.call(
          username: @faked_username,
          password: @faked_password,
          password_confirmation: @faked_password_confirmation,
          full_name: @faked_full_name
        )
      end
    end

    @user_class_mock.verify
    @user_instance_mock.verify
  end

  def test_unit_should_create_operator_user
    expected_new_params = {
      username: @faked_username,
      password: @faked_password,
      password_confirmation: @faked_password_confirmation,
      full_name: @faked_full_name,
      role: "OPERATOR",
      dashboard: false,
      detection: false,
      balancing: false,
      expense: false,
      category: false
    }

    @user_class_mock.expect(:new, @user_instance_mock, [ expected_new_params ])
    @user_instance_mock.expect(:save, true)
    @user_instance_mock.expect(:id, @faked_user_id)

    User.stub(:count, 1) do
      User.stub(:new, ->(params) { @user_class_mock.new(params) }) do
        UserServices::CreateUser.call(
          username: @faked_username,
          password: @faked_password,
          password_confirmation: @faked_password_confirmation,
          full_name: @faked_full_name
        )
      end
    end

    @user_class_mock.verify
    @user_instance_mock.verify
  end

  def test_unit_should_return_user_id
    @user_instance_mock.expect(:save, true)
    @user_instance_mock.expect(:id, @faked_user_id)

    User.stub(:count, SecureRandom.random_number) do
      User.stub(:new, @user_instance_mock) do
        result = UserServices::CreateUser.call(
          username: @faked_username,
          password: @faked_password,
          password_confirmation: @faked_password_confirmation,
          full_name: @faked_full_name
        )

        assert_equal({ user_id: @faked_user_id, error: nil }, result)
      end
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error
    @user_instance_mock.expect(:save, false)
    @user_instance_mock.expect(:errors, @user_errors_mock)
    @user_errors_mock.expect(:full_messages, [ @faked_error ])

    User.stub(:count, SecureRandom.random_number) do
      User.stub(:new, @user_instance_mock) do
        result = UserServices::CreateUser.call(
          username: @faked_username,
          password: @faked_password,
          password_confirmation: @faked_password_confirmation,
          full_name: @faked_full_name
        )

        assert_equal({ user_id: nil, error: @faked_error }, result)
      end
    end

    @user_instance_mock.verify
    @user_errors_mock.verify
  end

  def test_integration_should_create_record
    result = UserServices::CreateUser.call(
      username: @faked_username,
      password: @faked_password,
      password_confirmation: @faked_password,
      full_name: @faked_full_name
    )

    refute_nil User.find_by(id: result[:user_id])
  end
end
