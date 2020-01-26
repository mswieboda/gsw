module Gsw
  class Unit < Obj
    getter sprite : Sprite
    getter? selected : Bool

    @action : Action | Nil

    SPEED = 100

    def initialize(name, x, y)
      @sprite = Sprite.get(name)

      initialize(x: x, y: y, width: sprite.width, height: sprite.height)

      @action = nil
      @selected = false
    end

    def select(target : Vector)
      @selected = true if collision?(target)
    end

    def select(selection : SelectionBox)
      @selected = true if selection.collision?(self)
    end

    def deselect
      @selected = false
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

      if selected?
        LibRay.draw_rectangle_lines(
          pos_x: parent_x + x,
          pos_y: parent_y + y,
          width: width,
          height: height,
          color: LibRay::ORANGE
        )
      end
    end
  end
end
