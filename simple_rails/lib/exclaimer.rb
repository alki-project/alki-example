class Exclaimer
  def initialize(num)
    @num = num
  end

  def process(string)
    string + ('!' * @num)
  end
end
