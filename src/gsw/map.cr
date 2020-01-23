module Gsw
  class Map < Obj
    @objs : Array(Obj)

    def initialize(@x, @y, @width, @height)
      @objs = [] of Obj

      @objs << Ship.new(x: 50, y: 100)
    end

    def update
    end

    def draw
      LibRay.draw_rectangle(
        pos_x: x,
        pos_y: y,
        width: width,
        height: height,
        color: LibRay::GRAY
      )

      @objs.each(&.draw(x, y))
    end
  end
end
