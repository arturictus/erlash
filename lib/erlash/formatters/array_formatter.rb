module Erlash
  # ex:
  #    - 1
  #    - 2
  class ArrayFormatter < TemplateFormatter

    Erlash.formatters.register Array, self

    def format
      object.each_with_object([]) do |e, s|
        s << "  - #{format_elem(e)}"
      end
    end

  end
end
