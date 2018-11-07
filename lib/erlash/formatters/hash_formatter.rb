module Erlash

  # Given an array will format as a list
  # example:
  #     HashFormatter.new(formatter, {foo: 'foo', bar: 'bar'}).to_s
  #     #=> - foo: `foo`
  #         - bar: `bar`
  class HashFormatter < TemplateFormatter

    Erlash.formatters.register Hash, self

    def format
      object.each_with_object([]) do |(k, v), s|
        s << "  - #{k}: #{format_elem(v)}"
      end
    end
  end
end
