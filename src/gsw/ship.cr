module Gsw
  class Ship < Obj

    SIZE = 10

    def initialize(x, y)
      initialize(x: x, y: y, width: SIZE, height: SIZE)
    end

    def update
    end

    def draw(parent_x, parent_y)
      LibRay.draw_rectangle(
        pos_x: parent_x + x,
        pos_y: parent_y + y,
        width: width,
        height: height,
        color: LibRay::RED
      )
    end
  end
end
