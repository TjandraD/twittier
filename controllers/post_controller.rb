# frozen_string_literal: true

require_relative '../models/post'

class PostController
  def save(params)
    post = Post.new(params)

    { 'status' => 200 } if post.save_post == 200
  end
end
