require_relative '../../models/user'

describe User do
    before(:each) do
        @mock_client = double
        @user = User.new(id: 1, username: "johndoe", email: "johndoe@email.com", bio: "This is my bio")
        @client_response = {"id" => 1, "username" => "johndoe", "email" => "johndoe@email.com", "bio" => "This is my bio"}
        allow(Mysql2::Client).to receive(:new).and_return(@mock_client)
    end

    describe 'initialize user' do
        context 'when given valid params' do
            it 'should return true in valid? function' do
                valid_result = @user.valid?

                expect(valid_result).to eq(true)
            end
        end

        context 'when given invalid params' do
            it 'should return false in valid? function' do
                user = User.new(id: 1, username: "johndoe")

                valid_result = user.valid?

                expect(valid_result).to eq(false)
            end
        end
    end

    describe 'regist user' do
        context 'when given valid params' do
            it 'should save user data' do
                mock_query = "INSERT INTO users (username, email, bio) VALUES ('#{@user.username}', '#{@user.email}', '#{@user.bio}')"
                mock_query_get = "SELECT * FROM users WHERE id = 1"

                allow(@mock_client).to receive(:last_id).and_return(1)
                allow(@mock_client).to receive(:query).with(mock_query)
                allow(@mock_client).to receive(:query).with(mock_query_get).and_return([@client_response])

                function_result = @user.register
            end
        end

        context 'when given invalid params' do
            it 'should not execute query' do
                user = User.new({})

                function_result = user.register

                expect(function_result).to eq(422)
            end
        end
    end
end