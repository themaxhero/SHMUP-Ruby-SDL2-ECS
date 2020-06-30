require_relative "../Component/AccelerationComponent.rb"
require_relative "../Component/TransformComponent.rb"
require_relative "../ECS/System.rb"

class AccelerationSystem < System
  def initialize()
    super([TransformComponent, AccelerationComponent])
  end

  def iterate_entity(world, entity_id)
    entity = world.get_entity(entity_id)
    transform = entity.get_component(TransformComponent)
    acceleration = entity.get_component(AccelerationComponent)

    transform.x += acceleration.x
    transform.y += acceleration.y
  end
end
