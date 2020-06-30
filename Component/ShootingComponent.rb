require_relative "../ECS/Component.rb"

class ShootingComponent < Component
  attr_accessor :x, :y, :args

  def initialize()
    super()
    @x = 0
    @y = 0
    @args = []
  end
end
