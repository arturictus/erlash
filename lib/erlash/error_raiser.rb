require_relative 'trigger_template'
module Erlash
  class ErrorRaiser < TriggerTemplate
    def execute
      raise error
    end
  end
end
