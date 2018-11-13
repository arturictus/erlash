module Erlash
  # Experimental
  class ArrayRecursiveFormatter < TemplateFormatter
    class Nested < Struct.new(:val, :offset); end

    def format
      recursive_format
    end

    private

    def recursive_format
      objs = recursive_nesting(object)
      objs.each_with_object([]) do |n, s|
        if n.val.is_a?(Hash)
          format_elem(n.val).each do |fh|
            s << "#{"  "*n.offset}#{fh}"
          end
        else
          s << " #{"  "*n.offset} - #{format_elem(n.val)}"
        end
      end.flatten.join("\n")
    end

    def recursive_nesting(e, acc = [], offset = 0)
      if e.is_a?(Array)
        e.each{ |i| recursive_nesting(i, acc, offset + 1)}
      else
        acc << Nested.new(e, offset)
      end
      acc
    end

  end
end
