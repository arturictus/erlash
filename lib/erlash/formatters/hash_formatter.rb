module Erlash
  # ex:
  #    - foo: `foo`
  #    - bar: `bar`
  class HashFormatter < TemplateFormatter

    Erlash.formatters.register Hash, self

    def format
      elems = object.each_with_object([]) do |(k,v), o|
                o << "#{k}: #{v}"
              end
      "{ #{elems.join(", ")} }"
    end

    def experimental_formatting
      object.each_with_object([]) do |(k, v), s|
        if v.is_a?(Array)
          s << "  - #{k}:"
          s << "#{format_elem(v)}"
        else
          s << "  - #{k}: #{format_elem(v)}"
        end
      end
    end
  end
end
