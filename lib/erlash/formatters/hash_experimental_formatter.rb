module Erlash
  # Experimental
  class HashExperimentalFormatter < TemplateFormatter
    def format
      experimental_formatting
    end

    def experimental_formatting
      object.each_with_object([]) do |(k, v), s|
        if v.is_a?(Array)
          s << "  - #{k}:"
          s << "#{format_elem(v)}"
        else
          s << "  - #{k}: #{format_elem(v)}"
        end
      end
    end
  end
end
