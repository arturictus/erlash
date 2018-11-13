require 'spec_helper'
module Erlash
  describe MainHashFormatter do
    it 'formats as list' do
      formatter = Formatter.new(Formatters.new)
      described_class.call(formatter, {foo: :bar, bar: :foo})
      expected_message("#{described_class}_format_list") do |expected|
        expect(formatter.to_s).to eq(expected)
      end
    end
  end
end
