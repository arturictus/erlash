module Erlash
  class Base < StandardError
    class << self
      def problem(arg = nil, &block)
        @problem = block || arg
      end
      def sumary(arg = nil, &block)
        @sumary = block || arg
      end
      def resolution(arg = nil, &block)
        @resolution = block || arg
      end
    end
    attr_reader :params, :context

    def initialize(params = {})
      @params = params
      @context = params[:context]
      set_formatter
      super(formatter.to_s)
    end

    def problem
      @problem ||= exec_config self.class.instance_variable_get(:@problem)
    end
    def sumary
      @sumary ||= exec_config self.class.instance_variable_get(:@sumary)
    end
    def resolution
      @resolution ||= exec_config self.class.instance_variable_get(:@resolution)
    end

    def hints?
      !!(problem || sumary || resolution)
    end

    private

    def set_formatter
      formatter.tap do |f|
        f << Tip.new('Problem:', problem) if problem
        f << Tip.new('Sumary:', sumary) if sumary
        f << Tip.new('Resolution:', resolution) if resolution
        f << Context.new(self, context)
      end
    end

    def registry
      Erlash.formatters
    end

    def formatter
      @formatter ||= Formatter.new(registry)
    end

    def exec_config(val)
      if val.is_a?(Proc)
        val.call(context)
      else
        val
      end
    end
  end
end
