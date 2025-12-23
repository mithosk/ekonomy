module UserServices
  class UpdateUser
    def self.call(
      user_id:,
      username:,
      password:,
      password_confirmation:,
      full_name:,
      dashboard:,
      detection:,
      balancing:,
      expense:,
      category:,
      session_user_id:)
      session_user = User.find_by(id: session_user_id)
      if session_user.role != "ADMIN" and session_user_id != user_id
        return { error: "Only admins can edit other users" }
      end

      to_edit_user = User.find_by(id: user_id)

      to_edit_user.username = username
      to_edit_user.full_name = full_name

      if password and password.length > 0
        to_edit_user.password = password
        to_edit_user.password_confirmation = password_confirmation
      end

      if session_user.role == "ADMIN"
        to_edit_user.dashboard = dashboard
        to_edit_user.detection = detection
        to_edit_user.balancing = balancing
        to_edit_user.expense = expense
        to_edit_user.category = category
      end

      if to_edit_user.save
        {
          error: nil
        }
      else
        {
          error: to_edit_user.errors.full_messages.first
        }
      end
    end
  end
end
