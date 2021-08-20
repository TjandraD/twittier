class Attachment
    attr_reader :filename

    def initialize(params)
        @filename = params[:filename]
        @file = params[:tempfile]
    end

    def save
        File.open("./public/#{@filename}", "wb") do |f|
            f.write(@file.read)
        end
    end
end