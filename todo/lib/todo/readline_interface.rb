require 'readline'

module Todo
  class ReadlineInterface
    def initialize(prompt,handler)
      @prompt = prompt
      @handler = handler
    end

    def run
      while line = Readline.readline(@prompt, true)
        return unless @handler.handle(self,line)
      end
    end

    def strikethrough(string)
      "\e[9m#{string}\e[0m"
    end

    def echo(msg)
      puts msg
    end
  end
end
