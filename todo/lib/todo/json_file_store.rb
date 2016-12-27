require 'json'

module Todo
  class JsonFileStore
    def initialize(path)
      @path = path
    end

    def update
      data = read
      yield data
      write data
    end

    def read
      if File.exist? @path
        JSON.parse(File.read @path)['data']
      else
        []
      end
    end

    def write(data)
      File.write @path, {data:data}.to_json
    end
  end
end
