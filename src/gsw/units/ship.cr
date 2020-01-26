module Gsw
  class Ship < Unit
    SIZE = 100

    def initialize(x, y)
      initialize(name: "ship", x: x, y: y, width: SIZE, height: SIZE)
    end

    def draw(parent_x, parent_y)
      sprite.draw(
        x: parent_x + x,
        y: parent_y + y,
        rotation: rotation,
        tint: LibRay::RED
      )
    end
  end
end
