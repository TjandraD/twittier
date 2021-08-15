require_relative 'hashtag'

class Post
    attr_reader :user_id, :post_text, :datetime

    def initialize(params)
        @id = params[:id]
        @user_id = params[:user_id]
        @post_text = params[:post_text]
        @attachment = params[:attachment]
        @datetime = params[:datetime]
    end

    def valid?
        return false if @user_id.nil?
        return false if @post_text.nil? || @post_text.length > 1000
        return false if @datetime.nil?

        return true
    end

    def detect_hashtag
        return @post_text.downcase.scan(/#(\w+)/).flatten
    end

    def save_post
        return 422 unless self.valid?

        client = create_db_client
        client.query("INSERT INTO posts (user_id, post_text, datetime) VALUES (#{@user_id}, '#{@post_text}', #{@datetime})")
        response = client.query("SELECT * FROM posts WHERE id = #{client.last_id}")

        data = response.first
        post = Post.new({user_id: data["user_id"], post_text: data["post_text"], datetime: data["datetime"]})

        hashtags = self.detect_hashtag
        hashtags.each do |hashtag_name|
            hashtag = Hashtag.new(hashtag: hashtag_name)
            hashtag.save
            hashtag.save_post_hashtag(client.last_id)
        end

        return 200 unless self != post

        return 500
    end
end