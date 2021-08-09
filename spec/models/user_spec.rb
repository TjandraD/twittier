require_relative '../../models/user'

describe User do
    describe 'initialize user' do
        context 'when given valid params' do
            it 'should return true in valid? function' do
                user = User.new(id: 1, username: "johndoe", email: "johndoe@email.com", bio: "This is my bio")

                valid_result = user.valid?

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
end