module Gsw
  class Map < Obj
    @view : View
    @objs : Array(Obj)

    GRID_SIZE   = 10
    GRID_BORDER =  1

    def initialize(width, height, @view)
      initialize(x: 0, y: 0, width: width, height: height)

      @objs = [] of Obj

      @objs << Ship.new(x: 50, y: 100)
    end

    def move(dx : Int32 | Float32 = 0, dy : Int32 | Float32 = 0)
      @x += dx
      @y += dy
    end

    def update(frame_time : Float32)
      move_viewport(frame_time)
      mouse_click

      @objs.each(&.update(frame_time))
    end

    def move_viewport(frame_time)
      dx = dy = 0

      dx -= View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_LEFT, LibRay::KEY_A])
      dx += View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_RIGHT, LibRay::KEY_D])

      dy -= View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_UP, LibRay::KEY_W])
      dy += View::MOVE_SPEED * frame_time if Keys.down?([LibRay::KEY_DOWN, LibRay::KEY_S])

      @x += dx if @view.movable_x?(self, dx)
      @y += dy if @view.movable_y?(self, dy)
    end

    def mouse_click
      if Mouse.pressed?(Mouse::LEFT)
        mouse = Mouse.get

        if @view.viewable?({x: mouse[:x], y: mouse[:y], width: 1, height: 1})
          map_xy = {x: (mouse[:x] - x).to_i, y: (mouse[:y] - y).to_i}
          puts "go to #{map_xy}"
        end
      end
    end

    def draw(parent_x, parent_y)
      x = parent_x + @x
      y = parent_y + @y

      # Grid
      if Game::DEBUG
        (width / GRID_SIZE).to_i.times do |col|
          (height / GRID_SIZE).to_i.times do |row|
            grid_x = x + col * GRID_SIZE
            grid_y = y + row * GRID_SIZE
            size = GRID_SIZE

            next unless @view.viewable?({x: grid_x, y: grid_y, width: size, height: size})

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

      @objs.select { |obj| @view.viewable?({x: x + obj.x, y: y + obj.y, width: obj.width, height: obj.height}) }.each do |obj|
        obj.draw(x, y)
      end

      @view.draw
    end
  end
end
