module Erlash
  describe Formatter do
    it do
      registry = Formatters.new
      inst = Formatter.new(registry)
      inst << 1
      expect(inst.string).to eq "1\n"
    end

    it do
      registry = Formatters.new
      registry.register(String, Class.new(TemplateFormatter) do
        def format; "I'm string" end
      end)
      inst = Formatter.new(registry)
      inst << 'blabla'
      expect(inst.string).to eq "I'm string\n"
    end
  end
end
