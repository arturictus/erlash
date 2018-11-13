module Erlash
  class MainHashFormatter < TemplateFormatter
    def format
      object.each_with_object([]) do |(k, v), s|
        s << "  - #{k}: #{format_elem(v)}"
      end
    end
  end
end
