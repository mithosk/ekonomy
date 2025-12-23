module UserServices
  class AuthenticateUser
    def self.call(username:, password:)
      user = User.find_by(username: username)
      authenticated = user&.authenticate(password)

      {
        user_id: authenticated ? authenticated.id : nil
      }
    end
  end
end
