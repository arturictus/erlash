module Erlash
  class Formatter
    def self.call(inst, obj)
      registry = inst.registry
      formatter = registry.find(obj.class)
      if formatter
        formatter.call(inst, obj)
      else
        obj.to_s
      end
    end

    def self.format(inst, obj)
      registry = inst.registry
      formatter = registry.find(obj.class)
      if formatter
        formatter.format(inst, obj)
      else
        obj.to_s
      end
    end

    attr_reader :registry, :output, :objs, :options
    def initialize(registry, options = {})
      @registry = registry
      @output = StringIO.new
      @objs = []
      @options = options
    end

    def <<(elem)
      objs << elem
    end

    def to_s
      return @to_s if defined?(@to_s)
      objs.each do |e|
        output.puts format_elem(e)
      end
      @to_s = output.string
    end
    alias_method :string, :to_s

    private

    def format_elem(elem)
      self.class.format(self, elem)
    end
  end
end
