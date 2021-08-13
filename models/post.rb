class Post
    def initialize(params)
        @id = params[:id]
        @user_id = params[:user_id]
        @post_text = params[:post_text]
        @attachment = params[:attachment]
        @datetime = params[:datetime]
    end

    def valid?
        return false if @user_id.nil?
        return false if @post_text.nil?
        return false if @datetime.nil?

        return true
    end

    def detect_hashtag
        return @post_text.downcase.scan(/#(\w+)/).flatten
    end
end