require "cray"

require "./gsw/game"

module Gsw
  def self.run
    Game.new.run
  end
end

Gsw.run
