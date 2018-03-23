Alki do
  load :settings
  load :handlers

  service :handler do
    require 'fizzbuzz/switch_handler'
    Fizzbuzz::SwitchHandler.new [
      handlers.fizzbuzz,
      handlers.fizz,
      handlers.buzz,
      handlers.echo
    ]
  end

  func :run do
    range_handler.handle settings.range
  end

  service :range_handler do
    require 'fizzbuzz/range_handler'
    Fizzbuzz::RangeHandler.new handler
  end

  service :output do
    require 'fizzbuzz/line_output'
    Fizzbuzz::LineOutput.new settings.output_io
  end

  overlay 'settings.messages', :format_message
  set :format_message do
    -> msg { msg.capitalize+"!" }
  end
end
