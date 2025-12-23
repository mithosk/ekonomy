module UserServices
  class GetUserList
    def self.call
      User.order(full_name: :asc)
          .pluck(:id, :username, :full_name, :role)
          .map do |id, username, full_name, role|
        {
          user_id: id,
          username: username,
          full_name: full_name,
          role: role
        }
      end
    end
  end
end
