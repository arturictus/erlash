module Erlash
  class ArrayFormatter < TemplateFormatter
    def format
      elems = object.map{ |e| format_elem(e) }
      "[ #{elems.join(", ")} ]"
    end
  end
end
