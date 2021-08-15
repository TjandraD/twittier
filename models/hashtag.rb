class Hashtag
    def initialize(params)
        @id = params[:id]
        @name = params[:hashtag]
    end

    def valid?
        return false if @name.nil?

        return true
    end
end