class YearServices::UpdateYearTest < Minitest::Test
  def setup
    @year_instance_mock = Minitest::Mock.new
    @user_instance_mock = Minitest::Mock.new
    @year_errors_mock = Minitest::Mock.new

    @faked_year_id = SecureRandom.random_number
    @faked_user_id = SecureRandom.random_number
    @faked_target = SecureRandom.random_number
    @faked_date = Date.today
    @faked_error = SecureRandom.uuid
  end

  def test_unit_should_return_error_when_user_is_not_admin
    @user_instance_mock.expect(:role, "OPERATOR")

    User.stub(:find_by, @user_instance_mock) do
      result = YearServices::UpdateYear.call(
        year_id: @faked_year_id,
        target: @faked_target,
        session_user_id: @faked_user_id,
        ref_date: Date.new(@faked_date.year, 1, 14)
      )

      refute_nil result[:error]
    end

    @user_instance_mock.verify
  end

  def test_unit_should_return_error_when_ref_date_is_too_old
    @user_instance_mock.expect(:role, "ADMIN")
    @year_instance_mock.expect(:number, @faked_date.year)

    User.stub(:find_by, @user_instance_mock) do
      Year.stub(:find_by, @year_instance_mock) do
        result = YearServices::UpdateYear.call(
          year_id: @faked_year_id,
          target: @faked_target,
          session_user_id: @faked_user_id,
          ref_date: Date.new(@faked_date.year, 1, 15)
        )

        refute_nil result[:error]
      end
    end

    @year_instance_mock.verify
    @user_instance_mock.verify
  end

  def test_unit_should_save_year_with_error
    @user_instance_mock.expect(:role, "ADMIN")
    @year_instance_mock.expect(:number, @faked_date.year)
    @year_instance_mock.expect(:target=, nil, [ @faked_target ])
    @year_instance_mock.expect(:save, false)
    @year_instance_mock.expect(:errors, @year_errors_mock)
    @year_errors_mock.expect(:full_messages, [ @faked_error ])

    User.stub(:find_by, @user_instance_mock) do
      Year.stub(:find_by, @year_instance_mock) do
        result = YearServices::UpdateYear.call(
          year_id: @faked_year_id,
          target: @faked_target,
          session_user_id: @faked_user_id,
          ref_date: Date.new(@faked_date.year, 1, 14)
        )

        assert_equal result[:error], @faked_error
      end
    end

    @year_instance_mock.verify
    @user_instance_mock.verify
    @year_errors_mock.verify
  end

  def test_unit_should_save_year_without_error
    @user_instance_mock.expect(:role, "ADMIN")
    @year_instance_mock.expect(:number, @faked_date.year)
    @year_instance_mock.expect(:target=, nil, [ @faked_target ])
    @year_instance_mock.expect(:save, true)

    User.stub(:find_by, @user_instance_mock) do
      Year.stub(:find_by, @year_instance_mock) do
        result = YearServices::UpdateYear.call(
          year_id: @faked_year_id,
          target: @faked_target,
          session_user_id: @faked_user_id,
          ref_date: Date.new(@faked_date.year, 01, 14)
        )

        assert_nil result[:error]
      end
    end

    @year_instance_mock.verify
    @user_instance_mock.verify
  end
end
