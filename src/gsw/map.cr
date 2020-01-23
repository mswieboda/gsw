module Gsw
  class Map < Obj
    @objs : Array(Obj)

    GRID_SIZE = 10
    GRID_BORDER = 1

    def initialize(width, height)
      initialize(x: 0, y: 0, width: width, height: height)

      @objs = [] of Obj

      @objs << Ship.new(x: 50, y: 100)
    end

    def move(dx : Int32 | Float32 = 0, dy : Int32 | Float32 = 0)
      @x += dx
      @y += dy
    end

    def update
    end

    def draw(parent_x, parent_y)
      # Grid
      if Game::DEBUG
        LibRay.draw_rectangle(
          pos_x: parent_x + x,
          pos_y: parent_y + y,
          width: width,
          height: height,
          color: LibRay::BLUE
        )

        (width / GRID_SIZE).to_i.times do |grid_x|
          (height / GRID_SIZE).to_i.times do |grid_y|
            LibRay.draw_rectangle(
              pos_x: parent_x + x + grid_x * GRID_SIZE,
              pos_y: parent_y + y + grid_y * GRID_SIZE,
              width: GRID_SIZE - GRID_BORDER,
              height: GRID_SIZE - GRID_BORDER,
              color: LibRay::DARKGRAY
            )
          end
        end
      end

      @objs.each(&.draw(parent_x + x, parent_y + y))
    end
  end
end
