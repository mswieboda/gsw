module Gsw
  class Game
    SCREEN_WIDTH  = 1280
    SCREEN_HEIGHT =  768

    DEBUG = false

    TARGET_FPS = 60
    DRAW_FPS   = DEBUG

    def initialize
      LibRay.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "Galactic Space Wars")
      LibRay.init_audio_device
      LibRay.set_target_fps(TARGET_FPS)
    end

    def run
      while !LibRay.window_should_close?
        frame_time = LibRay.get_frame_time
        update(frame_time)
        draw_wrapper
      end

      close
    end

    def update(frame_time)
    end

    def draw
    end

    def draw_wrapper
      LibRay.begin_drawing
      LibRay.clear_background LibRay::BLACK

      draw

      LibRay.draw_fps(0, 0) if DRAW_FPS
      LibRay.end_drawing
    end

    def close
      LibRay.close_audio_device

      LibRay.close_window
    end
  end
end