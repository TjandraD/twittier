# frozen_string_literal: true

require_relative '../models/user'

class UserController
  def register(params)
    user = User.new(params)

    function_result = user.register

    return function_result if function_result.is_a?(Integer)

    {
      'status' => 200,
      'message' => 'Success',
      'user' => function_result
    }
  end
end
