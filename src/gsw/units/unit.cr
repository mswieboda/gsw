module Gsw
  class Unit < Obj
    getter sprite : Sprite

    @action : Action | Nil

    SIZE  = 100
    SPEED = 100

    def initialize(name, x, y, width, height)
      initialize(x: x, y: y, width: width, height: height)

      @sprite = Sprite.get(name)
      @action = nil
    end

    def queue(action : Action)
      @action = action
    end

    def finish
      @action = nil
    end

    def rotate_to(target : Vector)
      radians = Math.atan2(target.y - y, target.x - x)
      @rotation = radians * (180_f32 / Math::PI)
    end

    def move(direction : Vector, frame_time)
      @position += direction * SPEED * frame_time
    end

    def update(frame_time)
      @action.try(&.perform(frame_time))
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
