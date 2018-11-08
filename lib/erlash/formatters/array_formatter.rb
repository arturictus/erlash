module Erlash
  # ex:
  #    - 1
  #    - 2
  class ArrayFormatter < TemplateFormatter
    class Nested < Struct.new(:val, :offset); end
    Erlash.formatters.register Array, self

    def format
      # object.each_with_object([]) do |e, s|

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
      # end
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
