module Gsw
  class Vector
    property x : Int32 | Float32
    property y : Int32 | Float32

    def initialize(@x, @y)
    end

    def to_s(io : IO)
      io << "(x: #{x}, y: #{y})"
    end
  end
end
