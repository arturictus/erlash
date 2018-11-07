module Erlash
  describe Formatters do
    it 'register adds to the registry' do
      inst = described_class.new
      expect {
        inst.register(Array, proc { |e, opts| 'hello' } )
      }.to change(inst, :count)
    end

    it 'find' do
      inst = described_class.new
      inst.register(Array, 'example')
      expect(inst.find(Array)).to eq 'example'
    end

    it 'enumerable' do
      inst = described_class.new
      inst.register(Array, 'example')
      expect(inst.map{|k,v| k}).to eq [Array]
    end
  end
end
