require 'spec_helper'
module Erlash
  describe StringFormatter do
    it 'adds quotes to the string' do
      expected = "`hello`\n"
      formatter = Formatter.new(Formatters.new)
      described_class.call(formatter, 'hello')
      expect(formatter.to_s).to eq(expected)
    end
  end
end
