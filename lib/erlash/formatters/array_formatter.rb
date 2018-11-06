module Erlash

  # Given an array will format as a list
  # example:
  #     ArrayFormatter.new([1, 2]).error_message
  #     #=> - 1
  #         - 2
  class ArrayFormatter
    attr_reader :object, :opts, :output
    def initialize(object, opts = {})
      @object = object
      @opts = opts
      @output = opts[:output] || StringIO.new
    end

    def to_s
      object.each_with_object(output) do |e, s|
        s.puts "  - #{e}"
      end
      output.string
    end
  end
end
