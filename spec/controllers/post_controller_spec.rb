# frozen_string_literal: true

require_relative '../../controllers/post_controller'

describe PostController do
  before(:each) do
    @post_controller = PostController.new
    @post_params = { id: 1, user_id: 1, post_text: 'Hi, this is a post' }
  end

  describe 'save post' do
    it 'should store post into the database' do
      stub_model = double

      allow(Post).to receive(:new).with(@post_params).and_return(stub_model)
      allow(stub_model).to receive(:save_post).and_return(200)

      controller_result = @post_controller.save(@post_params)

      expect(controller_result).to eq(200)
    end
  end

  describe 'search post' do
    it 'should return posts which contains the desired hashtag' do
      stub_model = double

      allow(Post).to receive(:search).with('now').and_return(stub_model)
      allow(stub_model).to receive(:each).and_return('No post matched the hashtag')

      controller_result = @post_controller.search(hashtag: 'now')

      expect(controller_result).to eq({ 'posts' => 'No post matched the hashtag' })
    end
  end
end
