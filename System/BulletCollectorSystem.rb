require_relative "../Component/TransformComponent.rb"
require_relative "../Component/RenderComponent.rb"
require_relative "../Component/Projectile.rb"
require_relative "../ECS/System.rb"

class BulletCollectorSystem < System
  def initialize()
    super([TransformComponent, RenderComponent, Projectile])
  end

  def iterate_entity(world, entity_id)
    entity = world.get_entity(entity_id)
    transform = entity.get_component(TransformComponent)
    render = entity.get_component(RenderComponent)

    if transform.y < (0 + render.height) || transform.y > (720 - render.height)
      world.remove_entity(entity_id)
    end
  end
end
