module Gsw
  class View < Obj
    VIEW_PADDING    =  50
    MOVE_SPEED      = 150
    MOVE_HELD_SPEED = 500

    def map_initial_x
      x
    end

    def map_initial_y
      y
    end

    def movable_x?(map, dx)
      map_x = map.x + dx
      map_x + map.width > x + width && map_x < x
    end

    def movable_y?(map, dy)
      map_y = map.y + dy
      map_y + map.height > y + height && map_y < y
    end

    def update(frame_time, map : Map)
      move_map(frame_time, map)
    end

    def move_map(frame_time, map)
      dx = dy = 0

      speed = MOVE_SPEED * frame_time
      speed = MOVE_HELD_SPEED * frame_time if Keys.down?([LibRay::KEY_LEFT_SHIFT, LibRay::KEY_RIGHT_SHIFT])

      dx += speed if Keys.down?([LibRay::KEY_LEFT, LibRay::KEY_A])
      dx -= speed if Keys.down?([LibRay::KEY_RIGHT, LibRay::KEY_D])

      dy += speed if Keys.down?([LibRay::KEY_UP, LibRay::KEY_W])
      dy -= speed if Keys.down?([LibRay::KEY_DOWN, LibRay::KEY_S])

      return if dx == 0 && dy == 0

      new_x = map.x
      new_y = map.y

      new_x += dx if movable_x?(map, dx)
      new_y += dy if movable_y?(map, dy)

      map.position.x = new_x unless new_x == map.x
      map.position.y = new_y unless new_y == map.y
    end

    def viewable?(position : Vector, width : Int32 | Float32, height : Int32 | Float32)
      position.x + width > x &&
        position.x < x + @width &&
        position.y + height > y &&
        position.y < y + @height
    end

    def viewable?(obj : Obj)
      viewable?(obj.position, width: obj.width, height: obj.height)
    end

    def draw
      color = LibRay::ORANGE
      color.a = 50

      draw_viewport_border

      if Game::DEBUG
        LibRay.draw_rectangle_lines(
          pos_x: x,
          pos_y: y,
          width: width,
          height: height,
          color: color
        )
      end
    end

    def draw_viewport_border
      color = LibRay::BLACK

      # top
      LibRay.draw_rectangle(
        pos_x: 0,
        pos_y: 0,
        width: Game::SCREEN_WIDTH,
        height: Game::SCREEN_HEIGHT - height - y,
        color: color
      )

      # bottom
      LibRay.draw_rectangle(
        pos_x: 0,
        pos_y: Game::SCREEN_HEIGHT - y,
        width: Game::SCREEN_WIDTH,
        height: Game::SCREEN_HEIGHT - height - y,
        color: color
      )

      # left
      LibRay.draw_rectangle(
        pos_x: 0,
        pos_y: 0,
        width: Game::SCREEN_WIDTH - width - x,
        height: Game::SCREEN_HEIGHT,
        color: color
      )

      # right
      LibRay.draw_rectangle(
        pos_x: Game::SCREEN_WIDTH - x,
        pos_y: 0,
        width: Game::SCREEN_WIDTH - width - x,
        height: Game::SCREEN_HEIGHT,
        color: color
      )
    end
  end
end
