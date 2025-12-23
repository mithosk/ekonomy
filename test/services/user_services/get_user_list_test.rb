class UserServices::GetUserListTest < Minitest::Test
  def setup
    @user_class_mock = Minitest::Mock.new
    @user_instances_mock = Minitest::Mock.new

    @faked_id = SecureRandom.random_number
    @faked_username = SecureRandom.uuid
    @faked_full_name = SecureRandom.uuid
    @faked_role = SecureRandom.uuid

    @faked_user = Struct.new(:id, :username, :full_name, :role)
      .new(@faked_id, @faked_username, @faked_full_name, @faked_role)
  end

  def test_unit_should_order_and_pluck_users
    @user_instances_mock.expect(:pluck, @user_instances_mock, [ :id, :username, :full_name, :role ])
    @user_instances_mock.expect(:map, [])
    @user_class_mock.expect(:order, @user_instances_mock, [ { full_name: :asc } ])

    User.stub(:order, ->(params) { @user_class_mock.order(params) }) do
      UserServices::GetUserList.call
    end

    @user_class_mock.verify
    @user_instances_mock.verify
  end

  def test_unit_should_return_mapped_users
    User.stub(:order, [ @faked_user ]) do
      result = UserServices::GetUserList.call

      assert_equal(
        [
          {
            user_id: @faked_id,
            username: @faked_username,
            full_name: @faked_full_name,
            role: @faked_role
          }
        ],
        result
      )
    end
  end
end
