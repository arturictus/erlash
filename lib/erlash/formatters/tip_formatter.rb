module Erlash

  # Given an array will format as a list
  # example:
  #     ArrayFormatter.new([1, 2]).to_s
  #     #=> - 1
  #         - 2
  class TipFormatter < TemplateFormatter

    Erlash.formatters.register Tip, self

    def format
      [].tap do |acc|
        acc << object.title
        acc << "  #{object.description}"
      end
    end
  end
end
