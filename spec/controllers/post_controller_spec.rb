require_relative '../../controllers/post_controller'

describe PostController do
    before(:each) do
        @post_controller = PostController.new
        @post_params = {id: 1, user_id: 1, post_text: "Hi, this is a post"}
    end

    describe 'save post' do
        it 'should store post into the database' do
            stub_model = double

            allow(Post).to receive(:new).with(@post_params).and_return(stub_model)
            expect(stub_model).to receive(:save_post).and_return(200)

            controller_result = @post_controller.save(@post_params)

            expect(controller_result).to eq({"status" => 200})
        end
    end
end