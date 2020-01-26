module Gsw
  class Obj
    getter position : Vector
    getter width : Int32 | Float32
    getter height : Int32 | Float32
    getter rotation : Int32 | Float32 | Float64

    delegate :x, :y, to: position

    def initialize(x, y, @width, @height, @rotation = 0)
      @position = Vector.new(x: x, y: y)
    end

    def collision?(other : Vector)
      x < other.x &&
        x + width > other.x &&
        y < other.y &&
        y + height > other.y
    end

    def update(_frame_time)
    end

    def draw(_parent_x, _parent_y)
    end
  end
end
