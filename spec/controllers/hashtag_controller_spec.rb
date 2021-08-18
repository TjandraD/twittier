# frozen_string_literal: true

require_relative '../../controllers/hashtag_controller'

describe HashtagController do
  before(:each) do
    @hashtag_controller = HashtagController.new
  end

  describe 'get trending hashtags' do
    it 'should return all trending hashtags' do
      stub_return = double

      allow(Hashtag).to receive(:trending_hashtags).and_return(stub_return)
      allow(stub_return).to receive(:each)

      controller_result = @hashtag_controller.trending_hashtags

      expect(controller_result).to eq({
                                        'hashtags' => stub_return.each
                                      })
    end
  end
end
