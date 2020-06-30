require_relative "../Component/AccelerationComponent.rb"
require_relative "../Component/RenderComponent.rb"
require_relative "../Component/TransformComponent.rb"
require_relative "../Component/SpeedComponent.rb"
require_relative "../Component/Player.rb"
require_relative "../ECS/Entity.rb"

class Spaceship
  def self.create_entity(args = [])
    entity = Entity.new([
      TransformComponent,
      AccelerationComponent,
      RenderComponent,
      SpeedComponent,
      Player,
    ])
    speed = entity.get_component(SpeedComponent)
    speed.x = 1
    speed.y = 1
    render = entity.get_component(RenderComponent)
    render.filename = "../Assets/Sprites/Spaceship.png"

    return entity
  end
end
