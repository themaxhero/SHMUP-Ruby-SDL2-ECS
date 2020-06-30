require_relative "../Component/AccelerationComponent.rb"
require_relative "../Component/RenderComponent.rb"
require_relative "../Component/TransformComponent.rb"
require_relative "../ECS/Entity.rb"

class Bullet
  def self.create_entity(position, sy, enemy = true)
    entity = Entity.new([TransformComponent, AccelerationComponent, RenderComponent, Projectile])
    transform = entity.get_component(TransformComponent)
    x, y = position
    transform.x = x
    transform.y = y
    acceleration = entity.get_component(AccelerationComponent)
    acceleration.y = enemy ? sy : -sy
    render = entity.get_component(RenderComponent)
    render.filename = "../Assets/Sprites/Bullet.png"

    return entity
  end
end
