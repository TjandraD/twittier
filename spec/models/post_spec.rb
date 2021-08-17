# frozen_string_literal: true

require_relative '../../models/post'

describe Post do
  before(:each) do
    @mock_client = double
    @post_with_attachment = Post.new(id: 1, user_id: 1,
                                     post_text: "Hi! This is a post #now. And I'm here on #Singapore")
    @post_without_attachment = Post.new(id: 1, user_id: 1,
                                        post_text: "Hi! This is a post #now. And I'm here on #Singapore", attachment: 'some_file.txt')
    @client_response = { 'id' => 1, 'user_id' => 1,
                         'post_text' => "Hi! This is a post #now. And I'm here on #Singapore", 'datetime' => DateTime.now }
    allow(Mysql2::Client).to receive(:new).and_return(@mock_client)
    allow(@mock_client).to receive(:close)
  end

  describe 'save post' do
    context 'when given invalid params' do
      it 'should return false in valid? function' do
        post = Post.new(id: 1)

        valid_result = post.valid?

        expect(valid_result).to eq(false)
      end
    end

    context 'when given valid params and no attachment' do
      it 'should save post data' do
        mock_query = "INSERT INTO posts (user_id, post_text) VALUES (#{@post_without_attachment.user_id}, '#{@post_without_attachment.post_text}')"
        mock_query_get = 'SELECT * FROM posts WHERE id = 1'

        allow(@mock_client).to receive(:last_id).and_return(1)
        allow(@mock_client).to receive(:query).with(mock_query)
        allow(@mock_client).to receive(:query).with(mock_query_get).and_return([@client_response])

        stub_hashtag = double

        allow(Hashtag).to receive(:new).and_return(stub_hashtag)
        allow(stub_hashtag).to receive(:save)
        allow(stub_hashtag).to receive(:save_post_hashtag)

        expected_result = @post_without_attachment.save_post

        expect(expected_result).to eq(500)
      end
    end
  end

  describe 'extract hashtag' do
    it 'should return list of hashtags' do
      extracted_hashtag = @post_without_attachment.detect_hashtag

      expected_hashtag = %w[now singapore]

      expect(extracted_hashtag).to eq(expected_hashtag)
    end
  end
end
