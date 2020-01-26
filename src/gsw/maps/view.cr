module Gsw
  class View < Obj
    VIEW_PADDING =  50
    MOVE_SPEED   = 150

    def map_initial_x
      x + VIEW_PADDING
    end

    def map_initial_y
      y + VIEW_PADDING
    end

    def movable_x?(map, dx)
      map_x = map.x + dx
      map_x + map.width > x + width - VIEW_PADDING && map_x < x + VIEW_PADDING
    end

    def movable_y?(map, dy)
      map_y = map.y + dy
      map_y + map.height > y + height - VIEW_PADDING && map_y < y + VIEW_PADDING
    end

    def viewable?(position : Vector, width : Int32 | Float32, height : Int32 | Float32)
      position.x + width > x && position.x < x + @width && position.y + height > y && position.y < y + @height
    end

    def viewable?(obj : Obj)
      viewable?(obj.position, width: obj.width, height: obj.height)
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
