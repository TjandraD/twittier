require 'sinatra'
require 'json'
require_relative "controllers/user_controller"

before do
    content_type :json
end

post '/api/registration' do
    controller = UserController.new
    server_response = controller.register(params)

    return server_response.to_json
end