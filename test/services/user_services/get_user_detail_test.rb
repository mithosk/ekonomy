class UserServices::GetUserDetailTest < Minitest::Test
  def setup
    @user_class_mock = Minitest::Mock.new

    @faked_id = SecureRandom.random_number
    @faked_username = SecureRandom.uuid
    @faked_password = SecureRandom.uuid
    @faked_full_name = SecureRandom.uuid
    @faked_role = "ADMIN"
    @faked_dashboard = true
    @faked_detection = false
    @faked_balancing = true
    @faked_expense = false
    @faked_category = true

    @faked_user = Struct.new(:id, :username, :full_name, :role, :dashboard, :detection, :balancing, :expense, :category)
      .new(@faked_id, @faked_username, @faked_full_name, @faked_role, @faked_dashboard, @faked_detection, @faked_balancing, @faked_expense, @faked_category)
  end

  def test_unit_should_find_user_by_id
    @user_class_mock.expect(:find_by, @faked_user, [ { id: @faked_id } ])

    User.stub(:find_by, ->(params) { @user_class_mock.find_by(params) }) do
      UserServices::GetUserDetail.call(user_id: @faked_id)
    end

    @user_class_mock.verify
  end

  def test_unit_should_return_mapped_user_when_user_exist
    User.stub(:find_by, @faked_user) do
      result = UserServices::GetUserDetail.call(user_id: @faked_id)

      assert_equal(
        {
          username: @faked_username,
          full_name: @faked_full_name,
          role: @faked_role,
          dashboard: @faked_dashboard,
          detection: @faked_detection,
          balancing: @faked_balancing,
          expense: @faked_expense,
          category: @faked_category
        },
        result
      )
    end
  end

  def test_unit_should_return_nil_when_user_does_not_exist
    User.stub(:find_by, nil) do
      result = UserServices::GetUserDetail.call(user_id: @faked_id)

      assert_nil(result)
    end
  end

  def test_integration_should_return_mapped_user_when_user_exist
    user = User.new(
      username: @faked_username,
      password: @faked_password,
      password_confirmation: @faked_password,
      full_name: @faked_full_name,
      role: @faked_role,
      dashboard: @faked_dashboard,
      detection: @faked_detection,
      balancing: @faked_balancing,
      expense: @faked_expense,
      category: @faked_category
    )

    user.save

    result = UserServices::GetUserDetail.call(user_id: user.id)

    assert_equal(
      {
        username: @faked_username,
        full_name: @faked_full_name,
        role: @faked_role,
        dashboard: @faked_dashboard,
        detection: @faked_detection,
        balancing: @faked_balancing,
        expense: @faked_expense,
        category: @faked_category
      },
      result
    )
  end

  def test_integration_should_return_nil_when_user_does_not_exist
    result = UserServices::GetUserDetail.call(user_id: SecureRandom.random_number)

    assert_nil(result)
  end
end
