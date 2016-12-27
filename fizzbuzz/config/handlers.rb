Alki do
  factory :num_handler do
    require 'fizzbuzz/num_handler'
    -> (num,str) {
      Fizzbuzz::NumHandler.new(num, str, output)
    }
  end

  service :fizz do
    num_handler 3, settings.messages.fizz
  end

  service :buzz do
    num_handler 5, settings.messages.buzz
  end

  service :fizzbuzz do
    num_handler 15, settings.messages.fizzbuzz
  end

  service :echo do
    require 'fizzbuzz/echo_handler'
    Fizzbuzz::EchoHandler.new output
  end
end
