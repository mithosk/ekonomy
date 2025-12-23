module UserServices
  class GetUserDetail
    def self.call(user_id:)
      user = User.find_by(id: user_id)

      return nil unless user

      {
        username: user.username,
        full_name: user.full_name,
        role: user.role,
        dashboard: user.dashboard,
        detection: user.detection,
        balancing: user.balancing,
        expense: user.expense,
        category: user.category
      }
    end
  end
end
