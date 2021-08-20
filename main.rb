# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative 'controllers/user_controller'
require_relative 'controllers/post_controller'
require_relative 'controllers/hashtag_controller'

before do
  content_type :json
end

post '/api/registration' do
  controller = UserController.new
  server_response = controller.register(params)

  return server_response.to_json unless server_response.is_a?(Integer)

  status server_response
  body 'An error occured'
end

post '/api/new_post' do
  controller = PostController.new
  server_response = controller.save(params)

  return server_response.to_json unless server_response.is_a?(Integer)

  status server_response
  body 'An error occured'
end

post '/api/save_comment' do
  controller = PostController.new
  server_response = controller.save_comment(params)

  return server_response.to_json unless server_response.is_a?(Integer)

  status server_response
  body 'An error occured'
end

get '/api/search_post' do
  controller = PostController.new
  server_response = controller.search(params)

  return server_response.to_json
end

get '/api/trending_hashtags' do
  controller = HashtagController.new
  server_response = controller.trending_hashtags

  return server_response.to_json
end
