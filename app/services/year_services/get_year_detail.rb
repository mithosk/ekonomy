module YearServices
  class GetYearDetail
    def self.call(year_id:)
      year = Year.find_by(id: year_id)

      return nil unless year

      {
        number: year.number,
        target: year.target,
        updated_at: year.updated_at
      }
    end
  end
end
