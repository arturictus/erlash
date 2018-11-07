module Erlash
  # ex:
  #    - foo: `foo`
  #    - bar: `bar`
  class HashFormatter < TemplateFormatter

    Erlash.formatters.register Hash, self

    def format
      object.each_with_object([]) do |(k, v), s|
        s << "  - #{k}: #{format_elem(v)}"
      end
    end
  end
end
