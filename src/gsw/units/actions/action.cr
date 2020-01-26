module Gsw
  class Action
    def initialize(@unit : Unit)
    end

    def perform(_frame_time)
      raise "generic action"
    end
  end
end
