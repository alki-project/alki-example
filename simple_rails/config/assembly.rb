Alki do
  set(:home_message){
    exclaimer.process 'Hello World'
  }

  service :exclaimer do
    require 'exclaimer'
    Exclaimer.new 1
  end
end
