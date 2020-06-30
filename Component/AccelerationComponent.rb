require_relative "../ECS/Component.rb"

class AccelerationComponent < Component
  attr_accessor :x, :y

  def initialize(x = 0, y = 0)
    super()
    @x = x
    @y = y
  end
end
