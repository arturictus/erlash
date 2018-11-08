require 'spec_helper'
module Erlash
  describe ArrayFormatter do
    it 'formats as list' do
      expected = "  - 1\n  - 2\n"
      formatter = Formatter.new(Formatters.new)
      ArrayFormatter.call(formatter, [1, 2])
      expect(formatter.to_s).to eq(expected)
    end
  end
end
