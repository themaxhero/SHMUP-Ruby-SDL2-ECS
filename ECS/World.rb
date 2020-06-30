require_relative "../ECS/Entity.rb"
require_relative "../EntityArchetype/Spaceship.rb"

class World
  attr_accessor :entities, :systems, :running, :event_queue
  alias :is_running :running
  alias :running? :running

  def initialize(systems)
    @systems = systems
    @entities = {}
    @running = true
    @event_queue = []
  end

  def boot()
    puts "Booting World..."
    create_entity(Spaceship)
  end

  def create_entity(archetype = nil, *args)
    entity = archetype ? archetype.create_entity(*args) : Entity.new()
    @entities[entity.id] = entity
    return @entities[entity.id]
  end

  def get_entity(entity_id)
    return @entities[entity_id]
  end

  def emit(event)
    @event_queue << event
  end

  def remove_entity(id)
    @entities[id] = nil
  end

  def run()
    boot()
    while (self.running?)
      @systems.each { |ecs_system| ecs_system.run(self, @entities, @event_queue) }
      @event_queue = []
    end
  end
end
