module Gsw
  class Unit < Obj
    getter sprite : Sprite

    SIZE = 100

    def initialize(name, x, y, width, height)
      initialize(x: x, y: y, width: width, height: height)

      @sprite = Sprite.get(name)
    end

    def rotate_towards(target : Point)
      radians = Math.atan2(target.y - y, target.x - x)
      @rotation = radians * (180_f32 / Math::PI)
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
