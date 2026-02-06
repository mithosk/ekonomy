module YearServices
  class GetYearList
    def self.call
      Year.order(number: :asc)
          .pluck(:id, :number, :target, :updated_at)
          .map do |id, number, target, updated_at|
        {
          year_id: id,
          number: number,
          target: target,
          updated_at: updated_at
        }
      end
    end
  end
end
