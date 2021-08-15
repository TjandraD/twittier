require_relative '../../models/hashtag'

describe Hashtag do
    before(:each) do
        @mock_client = double
        @hashtag = Hashtag.new(id: 1, hashtag: "hello")
        @client_response = {"id" => 1, "hashtag" => "hello"}
        @invalid_client_response = {"id" => 1}
        allow(Mysql2::Client).to receive(:new).and_return(@mock_client)
    end

    describe 'initialize hashtag' do
        context 'when given valid params' do
            it 'should return true in valid? function' do
                valid_result = @hashtag.valid?

                expect(valid_result).to eq(true)
            end
        end

        context 'when given invalid params' do
            it 'should return false in valid? function' do
                hashtag = Hashtag.new({})

                valid_result = hashtag.valid?

                expect(valid_result).to eq(false)
            end
        end
    end

    describe 'save hashtag' do
        context 'when given valid params' do
            it 'should save a new hashtag' do
                mock_query = "INSERT INTO hashtags (hashtag) VALUES ('#{@hashtag.hashtag}')"
                mock_query_get = "SELECT * FROM hashtags WHERE hashtag = #{@hashtag.hashtag}"

                allow(@mock_client).to receive(:query).with(mock_query)
                allow(@mock_client).to receive(:query).with(mock_query_get).and_return([@client_response])

                function_result = @hashtag.save

                expect(function_result).to eq(200)
            end
        end

        context 'when return value is different' do
            it 'should return 500 status code' do
                mock_query = "INSERT INTO hashtags (hashtag) VALUES ('#{@hashtag.hashtag}')"
                mock_query_get = "SELECT * FROM hashtags WHERE hashtag = #{@hashtag.hashtag}"

                allow(@mock_client).to receive(:query).with(mock_query)
                allow(@mock_client).to receive(:query).with(mock_query_get).and_return([@invalid_client_response])

                function_result = @hashtag.save

                expect(function_result).to eq(500)
            end
        end
    end
end