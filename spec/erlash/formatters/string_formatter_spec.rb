require 'spec_helper'
module Erlash
  describe StringFormatter do
    it 'adds quotes to the string' do
      formatter = Formatter.new(Formatters.new)
      described_class.call(formatter, 'hello')
      expected_message(described_class) do |expected|
        expect(formatter.to_s).to eq(expected)
      end
    end
  end
end
