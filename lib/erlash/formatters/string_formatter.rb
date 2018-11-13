module Erlash
  # ex: `string`
  class StringFormatter < TemplateFormatter
    def format
      "`#{object}`"
    end
  end
end
