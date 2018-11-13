module Erlash
  class TipFormatter < TemplateFormatter
    def format
      [].tap do |acc|
        acc << object.title
        acc << "  #{object.description}"
      end
    end
  end
end
