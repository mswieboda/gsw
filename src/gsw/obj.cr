module Gsw
  class Obj
    getter point : Point
    getter width : Int32 | Float32
    getter height : Int32 | Float32
    getter rotation : Int32 | Float32

    delegate :x, :y, to: point

    def initialize(x, y, @width, @height, @rotation = 0)
      @point = Point.new(x: x, y: y)
    end

    def update(_frame_time)
    end

    def draw(_parent_x, _parent_y)
    end
  end
end
