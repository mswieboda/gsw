module Gsw
  class Vector
    property x : Int32 | Float32 | Float64
    property y : Int32 | Float32 | Float64

    def initialize(@x, @y)
    end

    def to_s(io : IO)
      io << "(x: #{x}, y: #{y})"
    end

    def length
      Math.sqrt(x * x + y * y)
    end

    def distance(v : Vector)
      (v - self).length
    end

    def normalize
      Vector.new(x: x / length, y: y / length)
    end

    def self.distance(v1 : Vector, v2 : Vector)
      v1.distance(v2)
    end

    {% for op in ["+", "-", "*", "/"] %}
      def {{op.id}}(other : Int32 | Float32 | Float64)
        Vector.new(x: x {{op.id}} other, y: y {{op.id}} other)
      end

      def {{op.id}}(other : Vector)
        Vector.new(x: x {{op.id}} other.x, y: y {{op.id}} other.y)
      end
    {% end %}
  end
end

{% for t in [Int32, Float32, Float64] %}
  struct {{t.id}}
    {% for op in ["+", "-", "*", "/"] %}
      def {{op.id}}(other : Gsw::Vector)
        other {{op.id}} self
      end
    {% end %}
  end
{% end %}
