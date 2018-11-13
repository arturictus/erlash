require 'spec_helper'
module Erlash
  describe ArrayFormatter do
    it 'delegates to_s to array' do
      formatter = Formatter.new(Formatters.new)
      described_class.call(formatter, [1, 2])
      expected_message("#{described_class}_single_line") do |expected|
        expect(formatter.to_s).to eq(expected)
      end
    end
    it 'formats elements' do |e|
      formatter = Formatter.new(Erlash.formatters)
      described_class.call(formatter, [1, {foo: 'bar'}])
      expected_message(e) do |expected|
        expect(formatter.to_s).to eq(expected)
      end
    end
  end
end
