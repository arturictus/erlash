module Erlash
  describe Base do
    it 'when only context' do
      b = described_class.new(context: "hello\n")
      expect(b.message).to eq("hello\n")
    end

    it 'when set simple strings as hints' do
      klass = Class.new(described_class) do
        problem 'this is a problem'
        sumary 'sumary'
        resolution 'resolution'
      end
      b = klass.new(context: 'hello')
      expect(b.message).to eq("Problem:\n  this is a problem\nSumary:\n  sumary\nResolution:\n  resolution\nContext:\nhello\n")
    end

    it 'when procs as hints' do
      klass = Class.new(described_class) do
        problem {|context| "problem #{context}" }
        sumary {|context| "sumary #{context}" }
        resolution {|context| "resolution #{context}" }
      end
      b = klass.new(context: 'hello')
      expect(b.message).to eq("Problem:\n  problem hello\nSumary:\n  sumary hello\nResolution:\n  resolution hello\nContext:\nhello\n")
    end

    it "raising instance works" do
      msg = <<~MSG
            ExampleError: Problem:
              problem
            Sumary:
              sumary
            Resolution:
              resolution
            Context:
            hello
            MSG

      expect {
        raise ExampleError.new(context: 'hello')
      }.to raise_error(ExampleError)#.with_message("")
    end
    it "raising constant works" do
      msg = <<~MSG
            ExampleError: Problem:
              problem
            Sumary:
              sumary
            Resolution:
              resolution
            Context:
            hello
            MSG

      expect {
        raise ExampleError
      }.to raise_error(ExampleError)#.with_message("")
    end
  end
end
