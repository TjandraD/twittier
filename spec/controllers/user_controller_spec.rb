require_relative '../../controllers/user_controller'

describe UserController do
    before(:each) do
        @user_controller = UserController.new
        @user_params = {id: 1, username: "johndoe", email: "johndoe@email.com", bio: "This is my bio"}
    end

    describe 'register user' do
        context 'when having server error' do
            it 'should return status 500' do
                stub_model = double

                allow(User).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:register).and_return(500)

                controller_result = @user_controller.register([])

                expect(controller_result).to eq({
                    "message" => "Internal server error",
                    "status" => 500
                    })
            end
        end

        context 'when given invalid params' do
            it 'should return status 422' do
                stub_model = double

                allow(User).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:register).and_return(422)

                controller_result = @user_controller.register([])

                expect(controller_result).to eq({
                    "status" => 422,
                    "message" => "Parameters error, check your parameters again"
                    })
            end
        end

        context 'when given valid params' do
            it 'should return status 200' do
                stub_model = double
                mock_user_return = double
                
                allow(User).to receive(:new).with(@user_params).and_return(stub_model)
                allow(stub_model).to receive(:register).and_return(mock_user_return)
                allow(mock_user_return).to receive(:each)

                controller_result = @user_controller.register(@user_params)

                expect(controller_result).to eq({
                    "status" => 200,
                    "message" => "Success",
                    "user" => mock_user_return.each
                })
            end
        end
    end
end