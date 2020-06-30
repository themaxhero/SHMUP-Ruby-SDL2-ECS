class System
  attr_reader :running_component_type

  def initialize(systems)
    @running_component_type = systems
  end

  def sort_id_component(entities, world)
    return entities
  end

  def run(world, entities, event_queue)
    entities_id = entities.reduce([]) { |acc, (k, v)|
      v && is_entity_elegible?(v) ? acc << k : acc
    }
    pre_entities_iteration(world)
    sort_id_component(entities_id, world).each { |entity_id| iterate_entity(world, entity_id) }
    post_entities_iteration(world)
  end

  def is_entity_elegible?(entity)
    elegible = @running_component_type.all? { |component| !!entity.get_component(component) }
    return elegible
  end

  def iterate_entity(world, entity_id)
    # puts "#{self.class.name}: Iterating #{entity_id} with Components #{components.map { |c| c.class.name }}"
  end

  def pre_entities_iteration(world)
    # puts "#{self.class.name}: Pre Entities"
  end

  def post_entities_iteration(world)
    # puts "#{self.class.name}: Post Entities"
  end
end
