module Erlash
  # ex:
  #    - 1
  #    - 2
  class ArrayFormatter < TemplateFormatter

    Erlash.formatters.register Array, self

    def format
      object.each_with_object([]) do |e, s|
        s << recursive_fix(e, 1)
      end
    end

    def recursive_fix(e, prefix_amount = 0)
      if e.is_a?(Array)
        e.map do |s|
          recursive_fix(format_elem(s), prefix_amount + 1)
        end
      else
        pr = (" "*prefix_amount)
        "#{pr} - #{format_elem(e)}"
      end

    end

  end
end
