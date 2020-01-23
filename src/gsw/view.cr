module Gsw
  class View < Obj
    VIEW_PADDING = 50
    MOVE_SPEED = 150

    def initialize(@x, @y, @width, @height)
      @view_y = @view_x = 0
    end

    def viewable_x?(obj_x, obj_width)
      obj_x + obj_width > x + width - VIEW_PADDING && obj_x < x + VIEW_PADDING
    end

    def viewable_y?(obj_y, obj_height)
      obj_y + obj_height > y + height - VIEW_PADDING && obj_y < y + VIEW_PADDING
    end

    def viewable?(obj : Obj)
      obj.x + obj.width > x && obj.x < x + width && obj.y + obj.height > y && obj.y < y + height
    end

    def draw
      LibRay.draw_rectangle_lines(
        pos_x: x,
        pos_y: y,
        width: width,
        height: height,
        color: LibRay::ORANGE
      )
    end
  end
end
