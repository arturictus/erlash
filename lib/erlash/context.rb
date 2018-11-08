module Erlash
  class Context
    attr_reader :formatter, :value
    def initialize(formatter, value)
      @formatter = formatter
      @value = value
    end
  end
end
