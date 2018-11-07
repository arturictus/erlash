module Erlash

  # Given an array will format as a list
  # example:
  #     ArrayFormatter.new([1, 2]).to_s
  #     #=> - 1
  #         - 2
  class ArrayFormatter < TemplateFormatter

    Erlash.formatters.register Array, self

    def format
      object.each_with_object([]) do |e, s|
        s << "  - #{format_elem(e)}"
      end
    end

  end
end
