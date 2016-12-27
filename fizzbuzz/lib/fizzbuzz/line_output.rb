module Fizzbuzz
  class LineOutput
    def initialize(io)
      @io = io
    end
    
    def <<(msg)
      @io.puts msg
    end
  end
end
