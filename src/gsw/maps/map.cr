module Gsw
  class Map < Obj
    @view : View
    @selection : SelectionBox
    @units : Array(Unit)

    GRID_SIZE  = 16
    GRID_COLOR = LibRay::Color.new(r: 75, b: 75, g: 255, a: 35)

    def initialize(width, height, @view, @units = [] of Unit)
      initialize(x: @view.map_initial_x, y: @view.map_initial_y, width: width, height: height)

      @selection = SelectionBox.new
    end

    def update(frame_time : Float32)
      @view.update(frame_time, self)

      mouse_click

      @units.each(&.update(frame_time))
    end

    def mouse_click
      if Mouse.pressed?(Mouse::LEFT)
        mouse = Mouse.get

        if @view.viewable?(mouse, width: 1, height: 1)
          mouse.x -= x
          mouse.y -= y

          @units.each do |unit|
            if unit.selected?
              unit.deselect
            else
              unit.select(mouse)
            end
          end
        end
      end

      if Mouse.down?(Mouse::LEFT)
        mouse = Mouse.get

        if @view.viewable?(mouse, width: 1, height: 1)
          mouse.x -= x
          mouse.y -= y

          if @selection.selecting?
            @selection.current = mouse
          else
            @selection.start(mouse)
          end
        end
      end

      if Mouse.released?(Mouse::LEFT)
        if @selection.selecting?
          @units.each do |unit|
            unit.deselect if unit.selected?
            unit.select(@selection)
          end

          @selection.deselect
        end
      end

      if Mouse.pressed?(Mouse::RIGHT)
        mouse = Mouse.get

        if @view.viewable?(mouse, width: 1, height: 1)
          mouse.x -= x
          mouse.y -= y

          @units.select(&.selected?).each do |unit|
            unit.queue(Move.new(unit, mouse))
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
              color: GRID_COLOR
            )
          end
        end
      end

      @units.select { |u| viewable?(u) }.each do |unit|
        unit.draw(x, y)
      end

      @selection.draw(x, y)
      @view.draw
    end
  end
end
