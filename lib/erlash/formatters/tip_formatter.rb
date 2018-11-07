module Erlash  
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
