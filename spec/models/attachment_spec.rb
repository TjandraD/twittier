require_relative '../../models/attachment'

describe Attachment do
    describe 'initialized with an attachment' do
        it 'should return file name when filename attribute is called' do
            attachment = Attachment.new(filename: 'something.txt')

            filename = attachment.filename

            expect(filename).to eq('something.txt')
        end
    end

    describe 'save attachment' do
        it 'should save attachment to the server' do
            mock_file = double
            mock_tempfile = double

            allow(mock_tempfile).to receive(:read)

            attachment = Attachment.new(filename: 'something.txt', tempfile: mock_tempfile)

            allow(File).to receive(:open).with('./public/something.txt', 'wb').and_yield(mock_file)
            expect(mock_file).to receive(:write)

            attachment.save
        end
    end
end