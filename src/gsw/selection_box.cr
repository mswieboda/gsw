module Gsw
  class SelectionBox
    property current : Vector
    getter? selecting

    @position : Vector

    delegate :x, :y, to: position

    def initialize
      @position = @current = Vector.new
      @selecting = false
    end

    def start(mouse : Vector)
      @position = @current = mouse
      @selecting = true
    end

    def deselect
      initialize
    end

    def width
      @position.width(current).abs
    end

    def height
      @position.height(current).abs
    end

    def position
      width = @position.width(current)
      height = @position.height(current)

      return @position if width > 0 && height > 0

      x = @position.x
      y = @position.y

      x += width if width < 0
      y += height if height < 0

      Vector.new(x: x, y: y)
    end

    def collision?(obj : Obj)
      obj.x < x + width &&
        obj.x + obj.width > x &&
        obj.y < y + height &&
        obj.y + obj.height > y
    end

    def draw(parent_x, parent_y)
      return unless selecting?

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
