class Player
  attr_reader :computer, :name, :mark

  def initialize(name, mark, computer = false)
    @name = name
    @mark = mark
    @computer = computer
  end
end
