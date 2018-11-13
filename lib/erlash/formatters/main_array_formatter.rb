module Erlash
  class MainArrayFormatter < TemplateFormatter
    Erlash.formatters.register Erlash::MainArray, self

    def format
      object.each_with_object([]) do |e, s|
        s << "  - #{format_elem(e)}"
      end
    end
  end
end
