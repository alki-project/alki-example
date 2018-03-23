require 'alki/test'
require 'todo/json_file_store'

describe Todo::JsonFileStore do
  before do
    @dir = Dir.mktmpdir
    @path = File.join(@dir,'store.json')
  end

  after do
    File.delete @path if File.exist? @path
    Dir.rmdir @dir
  end

  def write(json)
    File.write(@path,json)
  end

  let(:store) do
    Todo::JsonFileStore.new @path
  end

  describe :read do
    describe "when store doesn't exist" do
      it 'should return an empty array' do
        store.read.must_equal []
      end

      it 'should not create it' do
        store.read
        File.exist?(@path).must_equal false
      end
    end

    describe 'when store exists' do
      before do
        write('{"data": [1,2,3]}')
      end
      it 'should equal data attribute' do
        store.read.must_equal [1,2,3]
      end
    end
  end

  describe :write do
    describe "when store doesn't exist" do
      before do
        store.write([1,2,3])
      end

      it 'should create it' do
        File.exist?(@path).must_equal true
      end

      it 'should write the data to the file' do
        File.read(@path).must_equal '{"data":[1,2,3]}'
      end
    end

    describe "when store exists" do
      before do
        store.write([1])
      end
      it 'should overwrite it with the new data' do
        store.write([1,2,3])
        File.read(@path).must_equal '{"data":[1,2,3]}'
      end
    end
  end
end
