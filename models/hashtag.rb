# frozen_string_literal: true

require_relative '../db/db_connector'

class Hashtag
  attr_reader :hashtag

  def initialize(params)
    @id = params[:id]
    @hashtag = params[:hashtag]
  end

  def valid?
    return false if @hashtag.nil?

    true
  end

  def ==(other)
    @hashtag == other.hashtag
  end

  def save
    return 422 unless valid?

    client = create_db_client
    exists_hashtag = client.query("SELECT * FROM hashtags WHERE hashtag = '#{@hashtag}'")

    client.query("INSERT INTO hashtags (hashtag) VALUES ('#{@hashtag}')") if exists_hashtag.first.nil?
    response = client.query("SELECT * FROM hashtags WHERE hashtag = '#{@hashtag}'")

    data = response.first
    hashtag = Hashtag.new(id: data['id'], hashtag: data['hashtag'])

    client.close

    return 200 if self == hashtag

    500
  end

  def save_post_hashtag(post_id)
    client = create_db_client

    response = client.query("SELECT id FROM hashtags WHERE hashtag = '#{@hashtag}'")

    data = response.first
    hashtag_id = data['id']

    client.query("INSERT INTO post_hashtag VALUES (#{post_id}, #{hashtag_id})")

    client.close
  end

  def self.search(hashtag)
    client = create_db_client
    response = client.query("SELECT * FROM hashtags WHERE hashtag = '#{hashtag.downcase}'")

    client.close

    return response.first['id'] unless response.first.nil?

    nil
  end
end
