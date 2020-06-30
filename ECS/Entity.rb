require "securerandom"

class Entity
  attr_accessor :id, :components

  def initialize(component_classes = [])
    @id = SecureRandom.uuid()
    @components = component_classes.map { |klass| klass.new() }
  end

  def get_component(component_type)
    return @components.find { |c| c.is_a?(component_type) }
  end
end
