module Fizzbuzz
  class NumHandler
    def initialize(num,message,output)
      @num = num
      @msg = message
      @output = output
    end

    def handle(val)
      if val % @num == 0
        @output << @msg
        true
      end
    end
  end
end
