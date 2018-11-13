module Erlash
  # ex:
  #    {foo: "foo"} => { foo: `foo` }
  class HashFormatter < TemplateFormatter
    def format
      elems = object.each_with_object([]) do |(k,v), o|
                o << "#{k}: #{format_elem(v)}"
              end
      "{ #{elems.join(", ")} }"
    end
  end
end
