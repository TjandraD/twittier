require_relative '../../controllers/user_controller'

describe UserController do
    before(:each) do
        @user_controller = UserController.new
    end

    describe 'register user' do
        context 'when given valid params' do
            stub_model = double

            allow(User).to receive(:new).with([]).and_return(stub_model)
            expect(stub_model).to receive(:register).and_return(500)

            @user_controller.register([])
        end
    end
end