# frozen_string_literal: true

require_relative '../../models/hashtag'

describe Hashtag do
  before(:each) do
    @mock_client = double
    @hashtag = Hashtag.new(id: 1, hashtag: 'hello')
    @client_response = { 'id' => 1, 'hashtag' => 'hello' }
    @invalid_client_response = { 'id' => 1 }
    allow(Mysql2::Client).to receive(:new).and_return(@mock_client)
    allow(@mock_client).to receive(:close)
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
        mock_query_get = "SELECT * FROM hashtags WHERE hashtag = '#{@hashtag.hashtag}'"

        allow(@mock_client).to receive(:query).with(mock_query)
        allow(@mock_client).to receive(:query).with(mock_query_get).and_return([@client_response])

        function_result = @hashtag.save

        expect(function_result).to eq(200)
      end
    end

    context 'when return value is different' do
      it 'should return 500 status code' do
        mock_query = "INSERT INTO hashtags (hashtag) VALUES ('#{@hashtag.hashtag}')"
        mock_query_get = "SELECT * FROM hashtags WHERE hashtag = '#{@hashtag.hashtag}'"

        allow(@mock_client).to receive(:query).with(mock_query)
        allow(@mock_client).to receive(:query).with(mock_query_get).and_return([@invalid_client_response])

        function_result = @hashtag.save

        expect(function_result).to eq(500)
      end
    end
  end

  describe 'save post hashtag' do
    it 'should store post id and hashtag id' do
      mock_query = 'INSERT INTO post_hashtag VALUES (1, 1)'
      mock_query_get = "SELECT id FROM hashtags WHERE hashtag = '#{@hashtag.hashtag}'"

      allow(@mock_client).to receive(:query).with(mock_query_get).and_return(['id' => 1])
      expect(@mock_client).to receive(:query).with(mock_query)

      @hashtag.save_post_hashtag(1)
    end
  end

  describe 'search hashtag' do
    it 'should return hashtag id' do
      mock_query = "SELECT * FROM hashtags WHERE hashtag = 'now'"

      allow(@mock_client).to receive(:query).with(mock_query).and_return(['id' => 1])

      query_result = Hashtag.search('now')

      expect(query_result).to eq(1)
    end
  end

  describe 'get trending hashtags' do
    it 'should return list of top 5 trending hashtags' do
      stub_return = double
      mock_query = "SELECT hashtags.hashtag, COUNT(hashtags.name) FROM hashtags JOIN post_hashtag ON post_hashtag.hashtag_id = hashtags.id JOIN posts ON posts.id = post_hashtag.post_id WHERE posts.timestamp > DATE_SUB(CURDATE(), INTERVAL 1 DAY) GROUP BY hashtags.name ORDER BY COUNT(hashtags.name) DESC LIMIT 5"

      allow(@mock_client).to receive(:query).with(mock_query).and_return(stub_return)

      query_result = Hashtag.trending_hashtags

      expect(query_result).to eq(stub_return)
    end
  end
end
