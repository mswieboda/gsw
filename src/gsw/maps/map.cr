module Gsw
  class Map < Obj
    @view : View
    @units : Array(Unit)

    GRID_SIZE   = 10
    GRID_BORDER =  1

    def initialize(width, height, @view, @units = [] of Unit)
      initialize(x: @view.map_initial_x, y: @view.map_initial_y, width: width, height: height)
    end

    def update(frame_time : Float32)
      move(frame_time)
      mouse_click

      @units.each(&.update(frame_time))
    end

    def move(frame_time)
      dx = dy = 0

      dx += View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_LEFT, LibRay::KEY_A])
      dx -= View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_RIGHT, LibRay::KEY_D])

      dy += View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_UP, LibRay::KEY_W])
      dy -= View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_DOWN, LibRay::KEY_S])

      return if dx == 0 && dy == 0

      new_x = x
      new_y = y

      new_x += dx if @view.movable_x?(self, dx)
      new_y += dy if @view.movable_y?(self, dy)

      move(new_x, new_y)
    end

    def move(new_x, new_y)
      @position.x = new_x unless new_x == x
      @position.y = new_y unless new_y == y
    end

    def mouse_click
      if Mouse.pressed?(Mouse::LEFT)
        target = Mouse.get

        if @view.viewable?(target, width: 1, height: 1)
          target.x -= x
          target.y -= y

          @units.each do |unit|
            unit.queue(Move.new(target))
          end
        end
      end
    end

    def viewable?(obj : Obj)
      viewable?(obj.x, obj.y, obj.width, obj.height)
    end

    def viewable?(obj_x, obj_y, width, height)
      @view.viewable?(Vector.new(x: x + obj_x, y: y + obj_y), width: width, height: height)
    end

    def draw(_parent_x, _parent_y)
      # Grid
      if Game::DEBUG
        (width / GRID_SIZE).to_i.times do |col|
          (height / GRID_SIZE).to_i.times do |row|
            grid_x = col * GRID_SIZE
            grid_y = row * GRID_SIZE
            size = GRID_SIZE

            next unless viewable?(grid_x, grid_y, size, size)

            LibRay.draw_rectangle_lines(
              pos_x: x + grid_x,
              pos_y: y + grid_y,
              width: size,
              height: size,
              color: LibRay::BLUE
            )
          end
        end
      end

      @units.select { |u| viewable?(u) }.each do |unit|
        unit.draw(x, y)
      end

      @view.draw
    end
  end
end
