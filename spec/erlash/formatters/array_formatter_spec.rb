require 'spec_helper'
module Erlash
  describe ArrayFormatter do
    it 'formats as list' do
      expected = "  - 1\n  - 2\n"
      expect(ArrayFormatter.new([1, 2]).to_s).to eq(expected)
    end
  end
end
