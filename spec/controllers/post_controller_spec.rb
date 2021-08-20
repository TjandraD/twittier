# frozen_string_literal: true

require_relative '../../controllers/post_controller'

describe PostController do
  before(:each) do
    @post_controller = PostController.new
    @post_params = { id: 1, user_id: 1, post_text: 'Hi, this is a post' }
  end

  describe 'save post' do
    context 'when given valid params' do
      it 'should store post into the database' do
        stub_model = double
        mock_post_return = double

        allow(Post).to receive(:new).with(@post_params).and_return(stub_model)
        allow(stub_model).to receive(:save_post).and_return(mock_post_return)
        allow(mock_post_return).to receive(:each)

        controller_result = @post_controller.save(@post_params)

        expect(controller_result).to eq({
                                          'status' => 200,
                                          'message' => 'Success',
                                          'post' => mock_post_return
                                        })
      end
    end
  end

  describe 'save comment' do
    it 'should call save_comment method from Post class' do
      stub_model = double
      mock_post_return = double

      allow(Post).to receive(:new).with(@post_params).and_return(stub_model)
      allow(stub_model).to receive(:save_comment).and_return(mock_post_return)
      allow(mock_post_return).to receive(:each)

      controller_result = @post_controller.save_comment(@post_params)

      expect(controller_result).to eq({
                                        'status' => 200,
                                        'message' => 'Success',
                                        'comment' => mock_post_return
                                      })
    end
  end

  describe 'search post' do
    context 'when a minimum of a post found' do
      it 'should return posts which contains the desired hashtag' do
        stub_model = double

        allow(Post).to receive(:search).with('now').and_return(stub_model)
        allow(stub_model).to receive(:each)

        controller_result = @post_controller.search(hashtag: 'now')

        expect(controller_result).to eq({ 'posts' => stub_model.each })
      end
    end

    context 'when no post were found' do
      it 'should return custom message in map' do
        allow(Post).to receive(:search).with('now').and_return(nil)

        controller_result = @post_controller.search(hashtag: 'now')

        expect(controller_result).to eq({ 'posts' => 'No post matched the hashtag' })
      end
    end
  end
end
