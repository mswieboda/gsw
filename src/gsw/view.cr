module Gsw
  class View < Obj
    @map : Map

    VIEW_PADDING = 50
    MOVE_SPEED = 150

    def initialize(x, y, width, height, @map : Map)
      initialize(x: x, y: y, width: width, height: height)
    end

    def update(frame_time)
      dx = dy = 0

      dx -= MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_LEFT, LibRay::KEY_A])
      dx += MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_RIGHT, LibRay::KEY_D])

      dy -= MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_UP, LibRay::KEY_W])
      dy += MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_DOWN, LibRay::KEY_S])

      # bounds
      dx = 0 if @map.x + dx + @map.width < width - VIEW_PADDING || @map.x + dx > 0 + VIEW_PADDING
      dy = 0 if @map.y + dy + @map.height < height - VIEW_PADDING || @map.y + dy > 0 + VIEW_PADDING
      @map.move(dx: dx, dy: dy) unless dx == 0 && dy == 0
    end

    def draw(parent_x, parent_y)
      @map.draw(x, y)

      LibRay.draw_rectangle_lines(
        pos_x: parent_x + x,
        pos_y: parent_y + y,
        width: width,
        height: height,
        color: LibRay::ORANGE
      )
    end
  end
end
