require_relative '../db/db_connector'

class User
    attr_reader :username, :email, :bio

    def initialize(params)
        @id = params[:id]
        @username = params[:username]
        @email = params[:email]
        @bio = params[:bio]
    end

    def valid?
        return false if @username.nil?
        return false if @email.nil?
        return false if @bio.nil?

        return true
    end

    def ==(other)
        @username == other.username &&
        @email == other.email &&
        @bio == other.bio
    end

    def register
        return 422 unless self.valid?

        client = create_db_client
        client.query("INSERT INTO users (username, email, bio) VALUES ('#{@username}', '#{@email}', '#{@bio}')")
        response = client.query("SELECT * FROM users WHERE id = #{client.last_id}")

        data = response.first
        user = User.new({username: data["username"], email: data["email"], bio: data["bio"]})

        return 200 if self == user

        return 500
    end
end