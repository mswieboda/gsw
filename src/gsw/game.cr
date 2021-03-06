require "./core/**"
require "./units/unit.cr"
require "./**"

module Gsw
  class Game
    SCREEN_WIDTH  = 1280
    SCREEN_HEIGHT =  768

    DEBUG = true

    TARGET_FPS = 60
    DRAW_FPS   = DEBUG

    def initialize
      LibRay.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "Galactic Space Wars")
      LibRay.clear_background(LibRay::BLACK)
      LibRay.set_target_fps(TARGET_FPS)
      LibRay.init_audio_device

      load_sprites

      width = (SCREEN_WIDTH / 1.5).to_i
      height = (SCREEN_HEIGHT / 1.5).to_i

      view = View.new(
        x: ((SCREEN_WIDTH - width) / 2).to_i,
        y: ((SCREEN_HEIGHT - height) / 2).to_i,
        width: width,
        height: height
      )

      @map = Map.new(
        width: 1600,
        height: 1000,
        view: view,
        units: [
          Ship.new(10, 75).as(Unit),
          Ship.new(25, 50).as(Unit),
          Ship.new(30, 125).as(Unit),
        ]
      )
    end

    def load_sprites
      Sprite.load(
        [
          {asset_file: "ship", frames: 1, rows: 1},
        ]
      )
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
      @map.update(frame_time)
    end

    def draw
      @map.draw(0, 0)
    end

    def draw_wrapper
      LibRay.begin_drawing

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
