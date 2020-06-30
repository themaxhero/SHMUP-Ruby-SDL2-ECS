require_relative "../ECS/Component.rb"

class RenderComponent < Component
  attr_accessor :filename
  attr_accessor :width
  attr_accessor :height
  attr_accessor :src_rect
  attr_accessor :rotation
  attr_accessor :tone
  attr_accessor :blend_mode
  attr_accessor :access_texture
  attr_accessor :flip

  def initialize()
    super()
    @filename = ""
    @src_rect = nil
    @rotation = 0
    @width = 0
    @height = 0
    @tone = [255, 255, 255, 255]
    @blend_mode = 0
    @access_texture = :static
    @flip = :flip_none
  end
end
