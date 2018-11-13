require 'spec_helper'
module Erlash
  describe TipFormatter do
    it 'formats as title, description' do
      formatter = Formatter.new(Formatters.new)
      described_class.call(formatter, Tip.new('Tip', 'hello'))
      expected_message(described_class) do |expected|
        expect(formatter.to_s).to eq(expected)
      end
    end
  end
end
