require_relative "../Component/TransformComponent.rb"
require_relative "../Component/RenderComponent.rb"
require_relative "../Component/Enemy.rb"
require_relative "../EntityArchetype/Bullet.rb"
require_relative "../ECS/System.rb"

class ShootingSystem < System
  attr_accessor :event_handlers

  def initialize
    super([TransformComponent, RenderComponent, Character])
  end

  def handle_spawn(world, entity_id)
    source_transform = world.get_entity(entity_id).get_component(TransformComponent)
    source_render = world.get_entity(entity_id).get_component(RenderComponent)
    character_tag = world.get_entity(entity_id).get_component(Character)
    is_enemy = character_tag.is_a?(Enemy)
    x = source_transform.x + (source_render.width / 2)
    y = is_enemy ? source_transform.y + source_render.height : source_transform.y
    source_position = [x, y]
    entity = world.create_entity(Bullet, source_position, 2, is_enemy)
  end

  def handle_keydown(world, entity_id, variables)
    case variables["key"]
    when "SHOT"
      handle_spawn(world, entity_id)
    end
  end

  def event_handle(event, world, entity_id)
    case event[:name]
    when "Input/KeyDown"
      handle_keydown(world, entity_id, event[:variables])
    end
  end

  def iterate_entity(world, entity_id)
    super(world, entity_id)
    world.event_queue.each { |event| event_handle(event, world, entity_id) }
  end

  def pre_entities_iteration(world)
    super(world)
  end

  def post_entities_iteration(world)
    super(world)
  end
end
