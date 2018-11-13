module Erlash
  class ContextFormatter < TemplateFormatter
    def format
      [].tap do |acc|
        acc << 'Context:' if object.formatter.hints?
        acc << format_elem(object.value)
      end
    end
  end
end
