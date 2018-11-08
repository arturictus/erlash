module Erlash
  class ContextFormatter < TemplateFormatter

    Erlash.formatters.register Context, self

    def format
      [].tap do |acc|
        acc << 'Context:' if object.formatter.hints?
        acc << format_elem(object.value)
      end
    end
  end
end
