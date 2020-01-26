module Gsw
  class Action
    def perform(_unit : Unit, _frame_time)
      raise "generic action"
    end
  end
end
