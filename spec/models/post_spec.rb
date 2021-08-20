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
                         'post_text' => "Hi! This is a post #now. And I'm here on #Singapore", 'timestamp' => nil }
    @invalid_client_response = { 'id' => 1 }
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

    context 'when return value is different' do
      it 'should return 500 status code' do
        mock_query = "INSERT INTO posts (user_id, post_text) VALUES (#{@post_without_attachment.user_id}, '#{@post_without_attachment.post_text}')"
        mock_query_get = 'SELECT * FROM posts WHERE id = 1'

        allow(@mock_client).to receive(:last_id).and_return(1)
        allow(@mock_client).to receive(:query).with(mock_query)
        allow(@mock_client).to receive(:query).with(mock_query_get).and_return([@invalid_client_response])

        stub_hashtag = double

        allow(Hashtag).to receive(:new).and_return(stub_hashtag)
        allow(stub_hashtag).to receive(:save)
        allow(stub_hashtag).to receive(:save_post_hashtag)

        expected_result = @post_without_attachment.save_post

        expect(expected_result).to eq(500)
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

        expect(expected_result).to eq({
                                        'id' => @post_without_attachment.id,
                                        'post_text' => @post_with_attachment.post_text,
                                        'timestamp' => nil,
                                        'user_id' => 1
                                      })
      end
    end
  end

  describe 'save comment' do
    context 'when data is successfully saved' do
      it 'should save comment as a post' do
        mock_query = "INSERT INTO comments VALUES (2, #{@post_without_attachment.id})"
        mock_query_get = "SELECT comment_id FROM comments WHERE comment_id = #{@post_without_attachment.id}"

        allow(@post_without_attachment).to receive(:save_post).and_return(@client_response)
        allow(@mock_client).to receive(:query).with(mock_query)
        allow(@mock_client).to receive(:query).with(mock_query_get).and_return(['comment_id' => 1])

        expected_result = @post_without_attachment.save_comment(2)

        expect(expected_result).to eq({
                                        'id' => @post_without_attachment.id,
                                        'post_text' => @post_with_attachment.post_text,
                                        'timestamp' => nil,
                                        'user_id' => 1
                                      })
      end
    end

    context 'when data is not saved successfully' do
      it 'should return 500 status code' do
        mock_query = "INSERT INTO comments VALUES (2, #{@post_without_attachment.id})"
        mock_query_get = "SELECT comment_id FROM comments WHERE comment_id = #{@post_without_attachment.id}"

        allow(@post_without_attachment).to receive(:save_post).and_return(@client_response)
        allow(@mock_client).to receive(:query).with(mock_query)
        allow(@mock_client).to receive(:query).with(mock_query_get).and_return(['comment_id' => nil])

        expected_result = @post_without_attachment.save_comment(2)

        expect(expected_result).to eq(500)
      end
    end
  end

  describe 'search post' do
    it 'should return all post that having the searched hashtag' do
      mock_query = 'SELECT * FROM posts JOIN post_hashtag ON post_hashtag.post_id = posts.id WHERE post_hashtag.hashtag_id = 1'

      allow(Hashtag).to receive(:search).with('now').and_return(1)
      allow(@mock_client).to receive(:query).with(mock_query).and_return([])

      search_result = Post.search('now')

      expect(search_result).to eq([])
    end
  end

  describe 'extract hashtag' do
    it 'should return list of hashtags' do
      extracted_hashtag = @post_without_attachment.detect_hashtag

      expected_hashtag = %w[now singapore]

      expect(extracted_hashtag).to eq(expected_hashtag)
    end
  end

  describe 'map post data' do
    it 'should return map of post data' do
      map_result = @post_with_attachment.to_map

      expect(map_result).to eq({
                                 'id' => 1,
                                 'user_id' => 1,
                                 'post_text' => "Hi! This is a post #now. And I'm here on #Singapore",
                                 'timestamp' => nil
                               })
    end
  end
end
