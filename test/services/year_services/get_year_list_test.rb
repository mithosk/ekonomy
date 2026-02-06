class YearServices::GetYearListTest < Minitest::Test
  def setup
    @year_class_mock = Minitest::Mock.new
    @year_instances_mock = Minitest::Mock.new

    @faked_year_id = SecureRandom.random_number
    @faked_number = SecureRandom.random_number
    @faked_target = SecureRandom.random_number
    @faked_updated_at = Date.today

    @faked_year = Struct.new(:id, :number, :target, :updated_at)
      .new(@faked_year_id, @faked_number, @faked_target, @faked_updated_at)
  end

  def test_unit_should_order_and_pluck_years
    @year_instances_mock.expect(:pluck, @year_instances_mock, [ :id, :number, :target, :updated_at ])
    @year_instances_mock.expect(:map, [])
    @year_class_mock.expect(:order, @year_instances_mock, [ { number: :asc } ])

    Year.stub(:order, ->(params) { @year_class_mock.order(params) }) do
      YearServices::GetYearList.call
    end

    @year_class_mock.verify
    @year_instances_mock.verify
  end

  def test_unit_should_return_mapped_years
    Year.stub(:order, [ @faked_year ]) do
      result = YearServices::GetYearList.call

      assert_equal(
        [
          {
            year_id: @faked_year_id,
            number: @faked_number,
            target: @faked_target,
            updated_at: @faked_updated_at
          }
        ],
        result
      )
    end
  end
end
