require_relative '../models/post'

class PostController
    def save(params)
        post = Post.new(params)

        if (post.save_post == 200)
            return {"status" => 200}
        end
    end
end