require_relative 'trigger_template'
module Erlash
  class ErrorRaiser < TriggerTemplate
    def execute
      if error == :malformed
        raise Klass, context
      else
        raise error
      end
    end
  end
end
