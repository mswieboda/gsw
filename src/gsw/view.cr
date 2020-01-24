module Gsw
  class View < Obj
    VIEW_PADDING =  50
    MOVE_SPEED   = 150

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

      draw_temp_viewport_border
    end

    def draw_temp_viewport_border
      color = LibRay::BLACK

      # draw temp border around viewport
      # top
      LibRay.draw_rectangle(
        pos_x: x,
        pos_y: y - VIEW_PADDING * 2,
        width: width,
        height: VIEW_PADDING * 2,
        color: color
      )

      # bottom
      LibRay.draw_rectangle(
        pos_x: x,
        pos_y: y + height,
        width: width,
        height: VIEW_PADDING * 2,
        color: color
      )

      # left
      LibRay.draw_rectangle(
        pos_x: x - VIEW_PADDING * 2,
        pos_y: y - VIEW_PADDING * 2,
        width: VIEW_PADDING * 2,
        height: height + VIEW_PADDING * 4,
        color: color
      )

      # right
      LibRay.draw_rectangle(
        pos_x: x + width,
        pos_y: y - VIEW_PADDING * 2,
        width: VIEW_PADDING * 2,
        height: height + VIEW_PADDING * 4,
        color: color
      )
    end
  end
end
