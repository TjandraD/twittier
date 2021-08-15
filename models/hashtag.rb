class Hashtag
    attr_reader :hashtag

    def initialize(params)
        @id = params[:id]
        @hashtag = params[:hashtag]
    end

    def valid?
        return false if @hashtag.nil?

        return true
    end

    def ==(other)
        @hashtag == other.hashtag
    end

    def save
        return 422 unless self.valid?
        
        client = create_db_client
        client.query("INSERT INTO hashtags (hashtag) VALUES ('#{@hashtag}')")
        response = client.query("SELECT * FROM hashtags WHERE hashtag = #{@hashtag}")

        data = response.first
        hashtag = Hashtag.new(id: data["id"], hashtag: data["hashtag"])

        return 200 if self == hashtag

        return 500
    end
end