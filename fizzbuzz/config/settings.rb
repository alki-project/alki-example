Alki do
  set :args do
    ARGV
  end

  set :output_io do
    $stdout
  end

  set :range do
    if args.size != 2
      puts "Usage #{$0} FROM TO"
      exit 1
    end
    args[0].to_i..args[1].to_i
  end

  group :messages do
    service :fizz do
      "fizz"
    end
    service :buzz do
      "buzz"
    end
    service :fizzbuzz do
      "fizzbuzz"
    end
  end
end
