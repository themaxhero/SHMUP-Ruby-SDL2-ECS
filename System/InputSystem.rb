require "sdl2"
require_relative "../ECS/System.rb"

class InputSystem < System
  attr_accessor :window, :enabled, :keymap

  def initialize(window, keymap = nil)
    super([])
    @window = window
    @keymap = {}
    @keymap[SDL2::Key::Scan::UP] = "UP"
    @keymap[SDL2::Key::Scan::DOWN] = "DOWN"
    @keymap[SDL2::Key::Scan::LEFT] = "LEFT"
    @keymap[SDL2::Key::Scan::RIGHT] = "RIGHT"
    @keymap[SDL2::Key::Scan::Z] = "SHOT"
    @keymap[SDL2::Key::Scan::X] = "BOMB"
    @keymap[SDL2::Key::Scan::LSHIFT] = "SLOW_MODE"
    @keymap[SDL2::Key::Scan::ESCAPE] = "PAUSE"
    puts "Default Keymap: #{@keymap}"
  end

  def iterate_entity(world, entity_id)
    super(world, entity_id)
  end

  def iterate_event(acc, k, v)
    acc[k.gsub(/\:\100/, "")] = v

    return acc
  end

  def get_key_from_keymap(key)
    return @keymap[key]
  end

  def dispatch(world, event, variables)
    event_name = event.class.name.split("::").last
    world.emit({ name: "Input/" + event_name, variables: variables })
  end

  def pre_entities_iteration(world)
    super(world)
    while event = SDL2::Event.poll()
      # p event
      case event
      when SDL2::Event::Quit
        exit
      when SDL2::Event::KeyUp
        vars = {}
        vars["key"] = get_key_from_keymap(event.scancode)
        dispatch(world, event, vars)
      when SDL2::Event::KeyDown
        vars = {}
        vars["key"] = get_key_from_keymap(event.scancode)
        dispatch(world, event, vars)
      end
    end
  end

  def post_entities_iteration(world)
    super(world)
  end
end
