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

    private

    def set_formatter
      formatter.tap do |f|
        if problem
          f << 'Problem:'
          f << "  #{problem}"
        end
        if sumary
          f << 'Sumary:'
          f << "  #{sumary}"
        end
        if resolution
          f << 'Resolution:'
          f << "  #{resolution}"
        end
        if context
          f << 'Context:' if problem || sumary || resolution
          f << context
        end
      end
    end

    def formatter
      @formatter ||= Formatter.new
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
