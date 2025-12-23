module UserServices
  class CreateUser
    def self.call(username:, password:, password_confirmation:, full_name:)
      is_first_user = User.count.zero?

      user = User.new(
        username: username,
        password: password,
        password_confirmation: password_confirmation,
        full_name: full_name,
        role: is_first_user ? "ADMIN" : "OPERATOR",
        dashboard: is_first_user,
        detection: is_first_user,
        balancing: is_first_user,
        expense: is_first_user,
        category: is_first_user
      )

      if user.save
        {
          user_id: user.id,
          error: nil
        }
      else
        {
          user_id: nil,
          error: user.errors.full_messages.first
        }
      end
    end
  end
end
