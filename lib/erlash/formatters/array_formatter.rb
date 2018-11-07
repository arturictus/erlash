module Erlash

  # Given an array will format as a list
  # example:
  #     ArrayFormatter.new([1, 2]).to_s
  #     #=> - 1
  #         - 2
  class ArrayFormatter

    Erlash.formatters.register Array, self

    def self.call(*args)
      new(*args)
    end

    attr_reader :object, :opts, :output, :formatter
    def initialize(formatter, object, opts = {})
      @object = object
      @opts = opts
      @formatter = formatter
      @output = formatter.output
    end

    def call
      object.each_with_object(output) do |e, s|
        s.puts "  - #{format(e)}"
      end
    end

    def to_s
      call
      output.string
    end

    def format(elem)
      Formatter.call(formatter, elem)
    end
  end
end
