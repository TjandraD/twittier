# frozen_string_literal: true

require_relative 'hashtag'
require_relative '../db/db_connector'

class Post
  attr_reader :id, :user_id, :post_text

  def initialize(params)
    @id = params[:id]
    @user_id = params[:user_id].to_i
    @post_text = params[:post_text]
    @attachment = params[:attachment]
    @timestamp = params[:timestamp]
  end

  def valid?
    return false if @user_id.nil?
    return false if @post_text.nil? || @post_text.length > 1000

    true
  end

  def detect_hashtag
    @post_text.downcase.scan(/#(\w+)/).flatten.uniq
  end

  def ==(other)
    @user_id == other.user_id &&
      @post_text == other.post_text
  end

  def to_map
    {
      'id' => @id,
      'user_id' => @user_id,
      'post_text' => @post_text,
      'timestamp' => @timestamp
    }
  end

  def save_post
    return 422 unless valid?

    client = create_db_client
    client.query("INSERT INTO posts (user_id, post_text) VALUES (#{@user_id}, '#{@post_text}')")
    response = client.query("SELECT * FROM posts WHERE id = #{client.last_id}")

    data = response.first
    post = Post.new(id: data['id'], user_id: data['user_id'], post_text: data['post_text'], timestamp: data['timestamp'])

    post_id = client.last_id
    client.close

    hashtags = detect_hashtag
    hashtags.each do |hashtag_name|
      hashtag = Hashtag.new(hashtag: hashtag_name)
      hashtag.save
      hashtag.save_post_hashtag(post_id)
    end

    if self == post
      post.to_map
    else
      500
    end
  end
end
