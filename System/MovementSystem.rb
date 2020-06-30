require_relative "../Component/AccelerationComponent.rb"
require_relative "../Component/SpeedComponent.rb"
require_relative "../Component/Player.rb"
require_relative "../ECS/System.rb"

class MovementSystem < System
  attr_accessor :event_handlers

  def initialize
    super([SpeedComponent, AccelerationComponent, Player])
  end

  def handle_keydown(world, entity_id, acceleration, speed, variables)
    case variables["key"]
    when "UP"
      acceleration.y = -speed.y
    when "LEFT"
      acceleration.x = -speed.x
    when "RIGHT"
      acceleration.x = speed.x
    when "DOWN"
      acceleration.y = speed.y
    end
  end

  def handle_keyup(world, entity_id, acceleration, speed, variables)
    case variables["key"]
    when "UP"
      acceleration.y = 0
    when "LEFT"
      acceleration.x = 0
    when "RIGHT"
      acceleration.x = 0
    when "DOWN"
      acceleration.y = 0
    end
  end

  def event_handle(event, world, entity_id, acceleration, speed)
    case event[:name]
    when "Input/KeyDown"
      handle_keydown(world, entity_id, acceleration, speed, event[:variables])
    when "Input/KeyUp"
      handle_keyup(world, entity_id, acceleration, speed, event[:variables])
    end
  end

  def iterate_entity(world, entity_id)
    super(world, entity_id)
    acceleration = world
      .get_entity(entity_id)
      .get_component(AccelerationComponent)

    speed = world
      .get_entity(entity_id)
      .get_component(SpeedComponent)

    world.event_queue.each { |event| event_handle(event, world, entity_id, acceleration, speed) }
  end

  def pre_entities_iteration(world)
    super(world)
  end

  def post_entities_iteration(world)
    super(world)
  end
end
