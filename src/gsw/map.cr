module Gsw
  class Map < Obj
    @view : View
    @ships : Array(Ship)

    GRID_SIZE   = 10
    GRID_BORDER =  1

    def initialize(width, height, @view)
      initialize(x: @view.map_initial_x, y: @view.map_initial_y, width: width, height: height)

      @ships = [] of Ship

      @ships << Ship.new(x: 50, y: 100)
    end

    def update(frame_time : Float32)
      move(frame_time)
      mouse_click

      @ships.each(&.update(frame_time))
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
      @point.x = new_x unless new_x == x
      @point.y = new_y unless new_y == y
    end

    def mouse_click
      if Mouse.pressed?(Mouse::LEFT)
        target = Mouse.get

        if @view.viewable?(target, width: 1, height: 1)
          target.x -= x
          target.y -= y

          @ships.each do |ship|
            ship.rotate_towards(target)
          end
        end
      end
    end

    def draw(parent_x, parent_y)
      x = parent_x + point.x
      y = parent_y + point.y

      # Grid
      if Game::DEBUG
        (width / GRID_SIZE).to_i.times do |col|
          (height / GRID_SIZE).to_i.times do |row|
            grid_x = x + col * GRID_SIZE
            grid_y = y + row * GRID_SIZE
            size = GRID_SIZE

            next unless @view.viewable?(Point.new(x: grid_x, y: grid_y), width: size, height: size)

            LibRay.draw_rectangle_lines(
              pos_x: grid_x,
              pos_y: grid_y,
              width: size,
              height: size,
              color: LibRay::BLUE
            )
          end
        end
      end

      @ships.select { |obj| @view.viewable?(Point.new(x: x + obj.x, y: y + obj.y), width: obj.width, height: obj.height) }.each do |obj|
        obj.draw(x, y)
      end

      @view.draw
    end
  end
end
