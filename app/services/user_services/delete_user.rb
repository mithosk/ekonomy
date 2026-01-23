module UserServices
  class DeleteUser
    def self.call(user_id:, session_user_id:)
      to_delete_user = User.find_by(id: user_id)
      session_user = User.find_by(id: session_user_id)

      if session_user.role != "ADMIN"
        return { error: "Only administrators can delete users" }
      end

      if session_user_id == user_id
        return { error: "A user cannot delete himself" }
      end

      if to_delete_user.destroy
        {
          error: nil
        }
      else
        {
          error: to_delete_user.errors.full_messages.first
        }
      end
    end
  end
end
