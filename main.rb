require 'sinatra'
require 'json'
require_relative "controllers/user_controller"
require_relative "controllers/post_controller"

before do
    content_type :json
end

post '/api/registration' do
    controller = UserController.new
    server_response = controller.register(params)

    return server_response.to_json
end

post '/api/new_post' do
    controller = PostController.new
    server_response = controller.save(params)

    return server_response.to_json
end