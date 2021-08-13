require_relative '../../models/post'

describe Post do
    before(:each) do
        @mock_client = double
        @post_with_attachment = Post.new(id: 1, user_id: 1, post_text: "Hi! This is a post #now. And I'm here on #Singapore", datetime: DateTime.now)
        @post_without_attachment = Post.new(id: 1, user_id: 1, post_text: "Hi! This is a post #now. And I'm here on #Singapore", attachment: "some_file.txt", datetime: DateTime.now)
        allow(Mysql2::Client).to receive(:new).and_return(@mock_client)
    end

    describe 'save post' do
        context 'when given invalid params' do
            it 'should return false in valid? function' do
                post = Post.new(id: 1)

                valid_result = post.valid?

                expect(valid_result).to eq(false)
            end
        end
    end

    describe 'extract hashtag' do
        it 'should return list of hashtags' do
            extracted_hashtag = @post_without_attachment.detect_hashtag

            expected_hashtag = ['now', 'singapore']

            expect(extracted_hashtag).to eq(expected_hashtag)
        end
    end
end