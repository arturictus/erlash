require 'spec_helper'
module Erlash
  describe HashFormatter do
    it 'formats as list' do
      expected = "  - foo: bar\n  - bar: foo\n"
      formatter = Formatter.new(Formatters.new)
      described_class.call(formatter, {foo: :bar, bar: :foo})
      expect(formatter.to_s).to eq(expected)
    end
  end
end
