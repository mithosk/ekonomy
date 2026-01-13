class UserServices::UpdateUserTest < Minitest::Test
  def setup
    @user_instance_mock = Minitest::Mock.new
    @user_errors_mock = Minitest::Mock.new

    @faked_user_id = SecureRandom.random_number
    @faked_username = SecureRandom.uuid
    @faked_password = SecureRandom.uuid
    @faked_password_confirmation = SecureRandom.uuid
    @faked_full_name = SecureRandom.uuid
    @faked_dashboard = true
    @faked_detection = false
    @faked_balancing = true
    @faked_expense = false
    @faked_category = true
    @faked_error = SecureRandom.uuid
  end

  def test_unit_should_return_error_when_user_is_not_admin_and_not_self
    @user_instance_mock.expect(:role, "OPERATOR")

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: @faked_password,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: SecureRandom.random_number
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error_when_non_admin_edits_dashboard_flag
    @user_instance_mock.expect(:role, "OPERATOR")
    @user_instance_mock.expect(:dashboard, @faked_dashboard)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: @faked_password,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: !@faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error_when_non_admin_edits_detection_flag
    @user_instance_mock.expect(:role, "OPERATOR")
    @user_instance_mock.expect(:dashboard, @faked_dashboard)
    @user_instance_mock.expect(:detection, @faked_detection)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: @faked_password,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: !@faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error_when_non_admin_edits_balancing_flag
    @user_instance_mock.expect(:role, "OPERATOR")
    @user_instance_mock.expect(:dashboard, @faked_dashboard)
    @user_instance_mock.expect(:detection, @faked_detection)
    @user_instance_mock.expect(:balancing, @faked_balancing)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: @faked_password,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: !@faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error_when_non_admin_edits_expense_flag
    @user_instance_mock.expect(:role, "OPERATOR")
    @user_instance_mock.expect(:dashboard, @faked_dashboard)
    @user_instance_mock.expect(:detection, @faked_detection)
    @user_instance_mock.expect(:balancing, @faked_balancing)
    @user_instance_mock.expect(:expense, @faked_expense)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: @faked_password,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: !@faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error_when_non_admin_edits_category_flag
    @user_instance_mock.expect(:role, "OPERATOR")
    @user_instance_mock.expect(:dashboard, @faked_dashboard)
    @user_instance_mock.expect(:detection, @faked_detection)
    @user_instance_mock.expect(:balancing, @faked_balancing)
    @user_instance_mock.expect(:expense, @faked_expense)
    @user_instance_mock.expect(:category, @faked_category)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: @faked_password,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: !@faked_category,
        session_user_id: @faked_user_id
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_edit_user_without_password
    @user_instance_mock.expect(:username=, nil, [@faked_username])
    @user_instance_mock.expect(:full_name=, nil, [@faked_full_name])
    @user_instance_mock.expect(:role, "ADMIN")
    @user_instance_mock.expect(:dashboard=, nil, [@faked_dashboard])
    @user_instance_mock.expect(:detection=, nil, [@faked_detection])
    @user_instance_mock.expect(:balancing=, nil, [@faked_balancing])
    @user_instance_mock.expect(:expense=, nil, [@faked_expense])
    @user_instance_mock.expect(:category=, nil, [@faked_category])
    @user_instance_mock.expect(:save, true)

    User.stub(:find_by, @user_instance_mock) do
      UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: nil,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id
      )
    end

    @user_instance_mock.verify
  end

  def test_unit_should_edit_user_with_password
    @user_instance_mock.expect(:username=, nil, [@faked_username])
    @user_instance_mock.expect(:password=, nil, [@faked_password])
    @user_instance_mock.expect(:password_confirmation=, nil, [@faked_password_confirmation])
    @user_instance_mock.expect(:full_name=, nil, [@faked_full_name])
    @user_instance_mock.expect(:role, "ADMIN")
    @user_instance_mock.expect(:dashboard=, nil, [@faked_dashboard])
    @user_instance_mock.expect(:detection=, nil, [@faked_detection])
    @user_instance_mock.expect(:balancing=, nil, [@faked_balancing])
    @user_instance_mock.expect(:expense=, nil, [@faked_expense])
    @user_instance_mock.expect(:category=, nil, [@faked_category])
    @user_instance_mock.expect(:save, true)

    User.stub(:find_by, @user_instance_mock) do
      UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: @faked_password,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id
      )
    end

    @user_instance_mock.verify
  end

  def test_unit_should_save_user_without_error
    @user_instance_mock.expect(:username=, nil, [@faked_username])
    @user_instance_mock.expect(:full_name=, nil, [@faked_full_name])
    @user_instance_mock.expect(:role, "ADMIN")
    @user_instance_mock.expect(:dashboard=, nil, [@faked_dashboard])
    @user_instance_mock.expect(:detection=, nil, [@faked_detection])
    @user_instance_mock.expect(:balancing=, nil, [@faked_balancing])
    @user_instance_mock.expect(:expense=, nil, [@faked_expense])
    @user_instance_mock.expect(:category=, nil, [@faked_category])
    @user_instance_mock.expect(:save, true)

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: nil,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id
      )

      assert_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_save_user_with_error
    @user_instance_mock.expect(:username=, nil, [@faked_username])
    @user_instance_mock.expect(:full_name=, nil, [@faked_full_name])
    @user_instance_mock.expect(:role, "ADMIN")
    @user_instance_mock.expect(:dashboard=, nil, [@faked_dashboard])
    @user_instance_mock.expect(:detection=, nil, [@faked_detection])
    @user_instance_mock.expect(:balancing=, nil, [@faked_balancing])
    @user_instance_mock.expect(:expense=, nil, [@faked_expense])
    @user_instance_mock.expect(:category=, nil, [@faked_category])
    @user_instance_mock.expect(:save, false)
    @user_instance_mock.expect(:errors, @user_errors_mock)
    @user_errors_mock.expect(:full_messages, [@faked_error])

    User.stub(:find_by, @user_instance_mock) do
      result = UserServices::UpdateUser.call(
        user_id: @faked_user_id,
        username: @faked_username,
        password: nil,
        password_confirmation: @faked_password_confirmation,
        full_name: @faked_full_name,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category,
        session_user_id: @faked_user_id,
      )

      assert_equal result[:error], @faked_error
    end

    @user_instance_mock.verify
    @user_errors_mock.verify
  end
end