require 'spec_helper'
module Erlash
  describe ContextFormatter do
    it 'formats with formatters' do
      formatter = Formatter.new(Formatters.new)
      base = Base.new
      described_class.call(formatter, Context.new(base, 'hello'))
      expected_message(described_class) do |expected|
        expect(formatter.to_s).to eq(expected)
      end
    end
  end
end
