# frozen_string_literal: true

require_relative '../models/post'

class PostController
  def save(params)
    post = Post.new(params)

    function_result = post.save_post

    return function_result if function_result.is_a?(Integer)

    {
      'status' => 200,
      'message' => 'Success',
      'post' => function_result
    }
  end

  def search(params)
    posts = Post.search(params[:hashtag])

    if posts.nil?
      return {
        'posts' => 'No post matched the hashtag'
      }
    end

    {
      'posts' => posts.each
    }
  end
end
