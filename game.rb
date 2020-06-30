#!/bin/sh env ruby
require_relative "./ECS/World.rb"
require_relative "./sdl_adapter.rb"
require_relative "./System/MovementSystem.rb"
require_relative "./System/AccelerationSystem.rb"
require_relative "./System/ShootingSystem.rb"
require_relative "./System/BulletCollectorSystem.rb"

input_system, render_system = SDL2Adapter.input_and_render()

puts "Declaring World Systems..."
systems = [
  input_system,
  render_system,
  MovementSystem.new(),
  AccelerationSystem.new(),
  ShootingSystem.new(),
  BulletCollectorSystem.new(),
]
puts "Declaring World..."
world = World.new(systems)
puts "Entering the Game Loop..."
world.run()
