module Gsw
  class Ship < Obj
    getter sprite : Sprite

    SIZE = 100

    def initialize(x, y)
      initialize(x: x, y: y, width: SIZE, height: SIZE)

      @sprite = Sprite.get("ship")
    end

    def draw(parent_x, parent_y)
      sprite.draw_partial(
        x: parent_x + x,
        y: parent_y + y,
        rotation: 0,
        tint: LibRay::RED
      )
    end
  end
end
