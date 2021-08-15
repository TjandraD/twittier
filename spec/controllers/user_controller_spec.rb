require_relative '../../controllers/user_controller'

describe UserController do
    before(:each) do
        @user_controller = UserController.new
        @user_params = {id: 1, username: "johndoe", email: "johndoe@email.com", bio: "This is my bio"}
    end

    describe 'register user' do
        context 'when given invalid params' do
            it 'should return status 500' do
                stub_model = double

                allow(User).to receive(:new).with([]).and_return(stub_model)
                expect(stub_model).to receive(:register).and_return(500)

                controller_result = @user_controller.register([])

                expect(controller_result).to eq({"status" => 500})
            end
        end

        context 'when given valid params' do
            it 'should return status 200' do
                stub_model = double
                
                allow(User).to receive(:new).with(@user_params).and_return(stub_model)
                expect(stub_model).to receive(:register).and_return(200)

                controller_result = @user_controller.register(@user_params)

                expect(controller_result).to eq({"status" => 200})
            end
        end
    end
end