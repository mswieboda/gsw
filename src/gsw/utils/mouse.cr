module Gsw
  class Mouse
    LEFT   = LibRay::MOUSE_LEFT_BUTTON
    RIGHT  = LibRay::MOUSE_RIGHT_BUTTON
    MIDDLE = LibRay::MOUSE_MIDDLE_BUTTON

    def self.x
      LibRay.get_mouse_x
    end

    def self.y
      LibRay.get_mouse_y
    end

    def self.get
      Vector.new(x: x, y: y)
    end

    def self.pressed?(button)
      LibRay.mouse_button_pressed?(button)
    end

    def self.down?(button)
      LibRay.mouse_button_down?(button)
    end

    def self.released?(button)
      LibRay.mouse_button_released?(button)
    end

    def self.up?(button)
      LibRay.mouse_button_up?(button)
    end
  end
end
