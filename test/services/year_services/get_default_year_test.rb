class YearServices::GetDefaultYearTest < Minitest::Test
  def setup
    @year_class_mock = Minitest::Mock.new
    @year_instance_mock = Minitest::Mock.new

    @faked_year_id = SecureRandom.random_number
    @faked_date = Date.today
  end

  def test_unit_should_find_year_by_number
    @year_instance_mock.expect(:nil?, false)
    @year_instance_mock.expect(:id, @faked_year_id)
    @year_class_mock.expect(:find_by, @year_instance_mock, [ { number: @faked_date.year } ])

    Year.stub(:find_by, ->(params) { @year_class_mock.find_by(params) }) do
      YearServices::GetDefaultYear.call(ref_date: @faked_date)
    end

    @year_class_mock.verify
    @year_instance_mock.verify
  end

  def test_unit_should_create_year_when_not_present
    expected_new_params = {
      number: @faked_date.year,
      target: 0
    }

    @year_instance_mock.expect(:nil?, true)
    @year_instance_mock.expect(:save, nil)
    @year_instance_mock.expect(:id, @faked_year_id)
    @year_class_mock.expect(:new, @year_instance_mock, [ expected_new_params ])

    Year.stub(:find_by, @year_instance_mock) do
      Year.stub(:new, ->(params) { @year_class_mock.new(params) }) do
        YearServices::GetDefaultYear.call(ref_date: @faked_date)
      end
    end

    @year_class_mock.verify
    @year_instance_mock.verify
  end

  def test_unit_should_return_mapped_year
    @year_instance_mock.expect(:nil?, false)
    @year_instance_mock.expect(:id, @faked_year_id)

    Year.stub(:find_by, @year_instance_mock) do
      result = YearServices::GetDefaultYear.call(ref_date: @faked_date)

      assert_equal(
        {
          year_id: @faked_year_id
        },
        result
      )
    end

    @year_instance_mock.verify
  end
end
