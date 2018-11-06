module Erlash
  class Formatter
    attr_reader :output, :objs
    def initialize
      @output = StringIO.new
      @objs = []
    end

    def <<(elem)
      objs << elem
    end

    def to_s
      objs.each do |e|
        output.puts format_elem(e)
      end
      output.string
    end

    private

    def format_elem(elem)
      # if Formatter
      #   formatter.new(obj, output: output)
      # else
      #   to_s
      elem.to_s
    end
  end
end
