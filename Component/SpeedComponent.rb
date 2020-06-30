require_relative "../ECS/Component.rb"

class SpeedComponent < Component
  attr_accessor :x, :y

  def initialize(x = 0, y = 0)
    super()
    @x = x
    @y = y
  end
end
