require "cray"

require "./gsw/**"

module Gsw
  def self.run
    Game.new.run
  end
end

Gsw.run
