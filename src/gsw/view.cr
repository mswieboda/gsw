module Gsw
  class View < Obj
    @map : Map

    MOVE_SPEED = 5

    def initialize(x, y, width, height, @map : Map)
      initialize(x: x, y: y, width: width, height: height)
    end

    def update(_frame_time)
      dx = dy = 0

      dx -= MOVE_SPEED if Keys.down?([LibRay::KEY_LEFT, LibRay::KEY_A])
      dx += MOVE_SPEED if Keys.down?([LibRay::KEY_RIGHT, LibRay::KEY_D])

      dy -= MOVE_SPEED if Keys.down?([LibRay::KEY_UP, LibRay::KEY_W])
      dy += MOVE_SPEED if Keys.down?([LibRay::KEY_DOWN, LibRay::KEY_S])

      @map.move(dx: dx, dy: dy) unless dx == 0 && dy == 0
    end

    def draw(parent_x, parent_y)
      @map.draw(x, y)

      LibRay.draw_rectangle(
        pos_x: parent_x + x,
        pos_y: parent_y + y,
        width: width,
        height: height,
        color: LibRay::Color.new(r: 0, g: 0, b: 0, a: 155)
      )
    end
  end
end
