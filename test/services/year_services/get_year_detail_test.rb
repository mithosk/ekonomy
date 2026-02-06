class YearServices::GetYearDetailTest < Minitest::Test
  def setup
    @year_class_mock = Minitest::Mock.new

    @faked_year_id = SecureRandom.random_number
    @faked_number = SecureRandom.random_number
    @faked_target = SecureRandom.random_number
    @faked_updated_at = Date.today

    @faked_year = Struct.new(:id, :number, :target, :updated_at)
                        .new(@faked_id, @faked_number, @faked_target, @faked_updated_at)
  end

  def test_unit_should_find_year_by_id
    @year_class_mock.expect(:find_by, @faked_year, [ { id: @faked_year_id } ])

    Year.stub(:find_by, ->(params) { @year_class_mock.find_by(params) }) do
      YearServices::GetYearDetail.call(year_id: @faked_year_id)
    end

    @year_class_mock.verify
  end

  def test_unit_should_return_mapped_year_when_year_exist
    Year.stub(:find_by, @faked_year) do
      result = YearServices::GetYearDetail.call(year_id: @faked_year_id)

      assert_equal(
        {
          number: @faked_number,
          target: @faked_target,
          updated_at: @faked_updated_at
        },
        result
      )
    end
  end

  def test_unit_should_return_nil_when_year_does_not_exist
    Year.stub(:find_by, nil) do
      result = YearServices::GetYearDetail.call(year_id: @faked_year_id)

      assert_nil(result)
    end
  end
end
