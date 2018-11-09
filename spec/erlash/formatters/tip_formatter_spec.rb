require 'spec_helper'
module Erlash
  describe TipFormatter do
    it 'formats as title, description' do
      expected = "Tip\n  hello\n"
      formatter = Formatter.new(Formatters.new)
      described_class.call(formatter, Tip.new('Tip', 'hello'))
      expect(formatter.to_s).to eq(expected)
    end
  end
end
