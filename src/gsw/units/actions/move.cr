module Gsw
  class Move < Action
    getter target : Vector

    def initialize(@target)
    end

    def perform(unit : Unit, frame_time)
      # puts "moving to #{target} for #{unit}"
      unit.rotate_to(target)
      unit.move_towards(target, frame_time)

      # if close then complete action
      # unit.action_completed(self)
    end
  end
end
