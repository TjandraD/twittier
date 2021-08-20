class Attachment
    attr_reader :filename
    
    def initialize(params)
        @filename = params[:filename]
        @file = params[:tempfile]
    end
end