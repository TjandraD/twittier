require_relative '../models/user'

class UserController
    def register(params)
        user = User.new(params)

        function_result = user.register

        if (function_result == 422)
            return {
                "status" => 422,
                "message" => "Parameters error, check your parameters again"
            }
        elsif (function_result == 500)
            return {
                "status" => 500,
                "message" => "Internal server error"
            }
        else
            return {
                "status" => 200,
                "message" => "Success",
                "user" => function_result.each
            }
        end
    end
end