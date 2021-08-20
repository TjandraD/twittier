require_relative '../../models/attachment'

describe Attachment do
    describe 'initialized with an attachment' do
        it 'should return file name when filename attribute is called' do
            attachment = Attachment.new(filename: 'something.txt')

            filename = attachment.filename

            expect(filename).to eq('something.txt')
        end
    end
end