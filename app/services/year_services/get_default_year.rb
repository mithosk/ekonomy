module YearServices
  class GetDefaultYear
    def self.call(ref_date:)
      year = Year.find_by(number: ref_date.year)

      if year.nil?
        year = Year.new(
          number: ref_date.year,
          target: 0
        )

        year.save
      end

      {
        year_id: year.id
      }
    end
  end
end
