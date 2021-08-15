require_relative '../../models/hashtag'

describe Hashtag do
    before(:each) do
        @mock_client = double
        @hashtag = Hashtag.new(id: 1, hashtag: "hello")
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
end