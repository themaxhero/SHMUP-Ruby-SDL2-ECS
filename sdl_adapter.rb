require_relative "./System/InputSystem.rb"
require_relative "./System/RenderSystem.rb"

class SDL2Adapter
  def self.input_and_render(game_name = nil)
    x, y = 100, 100
    width = 1280
    height = 720
    title = game_name || "ECS, Game Example"
    puts "Initializing SDL2..."
    SDL2::IMG.init(SDL2::IMG::INIT_PNG)
    SDL2.init(SDL2::INIT_EVERYTHING)
    SDL2::ScreenSaver.disable
    puts "Creating game window..."
    window = SDL2::Window.create(title, x, y, width, height, 0)
    puts "Returning Input and Render Systems..."
    return [InputSystem.new(window), RenderSystem.new(window)]
  end
end
