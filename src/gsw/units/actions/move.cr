module Gsw
  class Move < Action
    getter performing : Bool
    getter unit : Unit
    getter target : Vector
    getter initial : Vector
    getter direction : Vector
    getter distance : Int32 | Float32 | Float64

    def initialize(@unit : Unit, @target : Vector)
      @performing = false
      @initial = unit.position
      @direction = (target - initial).normalize

      # TODO: calc distance - width/height (times rotation)
      @distance = initial.distance(target)
    end

    def perform(frame_time)
      unit.rotate_to(target) unless performing
      unit.move(direction, frame_time)

      if (initial.distance(unit.position) >= distance)
        # stop, remove action
        @unit.finish
      else
        @performing = true
      end
    end
  end
end
