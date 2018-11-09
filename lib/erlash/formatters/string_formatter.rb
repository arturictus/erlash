module Erlash
  # ex: `string`
  class StringFormatter < TemplateFormatter
    Erlash.formatters.register String, self

    def format
      "`#{object}`"
    end
  end
end
