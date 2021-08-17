# frozen_string_literal: true

require_relative '../models/user'

class UserController
  def register(params)
    user = User.new(params)

    function_result = user.register

    case function_result
    when 422
      {
        'status' => 422,
        'message' => 'Parameters error, check your parameters again'
      }
    when 500
      {
        'status' => 500,
        'message' => 'Internal server error'
      }
    else
      {
        'status' => 200,
        'message' => 'Success',
        'user' => function_result
      }
    end
  end
end
