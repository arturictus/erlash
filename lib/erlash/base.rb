module Erlash
  class Base < StandardError
    class << self
      def problem(arg = nil, &block)
        @problem = block || arg
      end
      def summary(arg = nil, &block)
        @summary = block || arg
      end
      def resolution(arg = nil, &block)
        @resolution = block || arg
      end
    end
    attr_reader :input

    def initialize(input = nil, opts = {})
      @input = input
      @opts = opts
      set_formatter
      super(formatter.to_s)
    end

    def problem
      @problem ||= exec_config(self.class.instance_variable_get(:@problem))
    end
    def summary
      @summary ||= exec_config(self.class.instance_variable_get(:@summary))
    end
    def resolution
      @resolution ||= exec_config(self.class.instance_variable_get(:@resolution))
    end

    def hints?
      !!(problem || summary || resolution)
    end

    private

    def set_formatter
      formatter.tap do |f|
        f << Tip.new('Problem:', problem) if problem
        f << Tip.new('Summary:', summary) if summary
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

    def context
      @context ||= case input
                   when Array
                     Erlash::MainArray.build(input)
                   when Hash
                     Erlash::MainHash.build(input)
                   else
                     input
                   end
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
