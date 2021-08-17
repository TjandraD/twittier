# frozen_string_literal: true

require 'mysql2'
require 'dotenv'

def create_db_client
  # Load the .env file
  Dotenv.load

  Mysql2::Client.new(
    host: 'localhost',
    username: ENV['DB_USERNAME'],
    password: ENV['DB_PASSWORD'],
    database: ENV['DB_DATABASE']
  )
end
