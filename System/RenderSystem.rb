require "sdl2"
require "objspace"
require_relative "../Component/TransformComponent"
require_relative "../Component/RenderComponent"
require_relative "../ECS/System.rb"

class RenderSystem < System
  def initialize(window)
    super([TransformComponent, RenderComponent])
    @window = window
    @renderer = @window.create_renderer(-1, SDL2::Renderer::Flags::ACCELERATED)
    @renderer.draw_color = [0, 0, 0, 255]
    @cached_textures = []
    @window_rect = SDL2::Rect[0, 0, 1280, 720]
    @access_texture = {
      static: SDL2::Texture::ACCESS_STATIC,
      streaming: SDL2::Texture::ACCESS_STREAMING,
      target: SDL2::Texture::ACCESS_TARGET,
    }
    @flip = {
      flip_h: SDL2::Renderer::FLIP_HORIZONTAL,
      flip_v: SDL2::Renderer::FLIP_VERTICAL,
      flip_b: SDL2::Renderer::FLIP_HORIZONTAL | SDL2::Renderer::FLIP_VERTICAL,
      flip_none: SDL2::Renderer::FLIP_NONE,
    }
  end

  def sort_id_component(entities, world)
    def get_transform(entity_id, world)
      return world.get_entity(entity_id).get_component(TransformComponent)
    end

    def component_list_sort(a, b)
      return 1 if a.z > b.z
      return -1 if a.z < b.z
      return 0
    end

    return entities.sort! { |a, b| component_list_sort(get_transform(a, world), get_transform(b, world)) }
  end

  def iterate_entity(world, entity_id)
    super(world, entity_id)
    transform = world
      .get_entity(entity_id)
      .get_component(TransformComponent)

    render = world
      .get_entity(entity_id)
      .get_component(RenderComponent)

    texture = invalidate_texture_cache(transform, render)
    src_rect = render.src_rect ? SDL2::Rect[*render.src_rect] : nil
    rect = SDL2::Rect[transform.x, transform.y, render.width, render.height]
    texture.blend_mode = render.blend_mode
    texture.color_mod = render.tone[0...3]
    render.width = texture.w
    render.height = texture.h
    angle = render.rotation
    @renderer.copy_ex(texture, src_rect, rect, angle, nil, @flip[render.flip])
  end

  def delete_textures_for_entity(texture_id, zpos)
    if @cached_textures[zpos] && @cached_textures[zpos][texture_id]
      @cached_textures[zpos][texture_id].destroy
      @cached_textures[zpos][texture_id] = nil
    end
  end

  def get_texture_for_entity_file(filename, zpos)
    return @cached_textures[zpos] && @cached_textures[zpos][filename]
  end

  def invalidate_texture_cache(transform, render)
    texture = get_texture_for_entity_file(render.filename, transform.z)
    if (!texture)
      texture_id = render.filename
      delete_textures_for_entity(texture_id, transform.z)
      @cached_textures[transform.z] = {} unless @cached_textures[transform.z]
      surface = SDL2::Surface.load(File.expand_path("../" + render.filename, __FILE__))
      surface.color_key = surface.pixel(0, 0)
      @cached_textures[transform.z][texture_id] = @renderer.create_texture_from(surface)
      surface.destroy
      surface = nil
      texture = @cached_textures[transform.z][texture_id]
      texture.blend_mode = render.blend_mode
      texture.color_mod = render.tone[0...3]
      render.width = texture.w
      render.height = texture.h

      return texture
    end

    return texture
  end

  def pre_entities_iteration(world)
    super(world)
    @renderer.clear()
  end

  def post_entities_iteration(world)
    super(world)
    @renderer.present()
  end

  def dispose_texture(texture)
    texture.destroy()
    texture = nil
  end

  def dispose_renderer()
    @renderer.destroy()
    @renderer = nil
  end

  def dispose_window()
    @window.destroy()
    @window = nil
  end
end
