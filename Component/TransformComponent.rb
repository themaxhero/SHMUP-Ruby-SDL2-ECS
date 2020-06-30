require_relative "../ECS/Component.rb"

class TransformComponent < Component
  attr_accessor :x, :y, :z

  def initialize(x = 0, y = 0, z = 0)
    super()
    @x = x
    @y = y
    @z = z
  end
end
