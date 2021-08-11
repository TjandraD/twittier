require_relative '../models/user'

class UserController
    def register(params)
        user = User.new(params)

        if (user.register == 200)
            return {"status" => 200}
        else
            return {"status" => 500}
        end
    end
end