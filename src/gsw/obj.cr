module Gsw
  class Obj
    getter x : Int32 | Float32
    getter y : Int32 | Float32
    getter width : Int32 | Float32
    getter height : Int32 | Float32

    def initialize(@x, @y, @width, @height)
    end

    def update
    end

    def draw(parent_x, parent_y)
    end
  end
end
