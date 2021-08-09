class User
    def initialize(params)
        @id = params[:id]
        @username = params[:username]
        @email = params[:email]
        @bio = params[:bio]
    end

    def valid?
        return false if @id.nil?
        return false if @username.nil?
        return false if @email.nil?
        return false if @bio.nil?

        return true
    end
end