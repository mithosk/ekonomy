module YearServices
  class UpdateYear
    def self.call(year_id:, target:, session_user_id:, ref_date:)
      if User.find_by(id: session_user_id).role != "ADMIN"
        return { error: "Only admins can edit years" }
      end

      year = Year.find_by(id: year_id)

      if ref_date > Date.new(year.number, 1, 14)
        return { error: "Is not possible to edit years after 14th of January" }
      end

      year.target = target

      if year.save
        {
          error: nil
        }
      else
        {
          error: year.errors.full_messages.first
        }
      end
    end
  end
end
