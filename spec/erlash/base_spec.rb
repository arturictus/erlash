module Erlash
  describe Base do
    it 'when only context' do
      b = described_class.new("hello")
      expect(b.message).to eq("`hello`\n")
    end

    it 'when set simple strings as hints' do
      klass = Class.new(described_class) do
        problem 'this is a problem'
        summary 'summary'
        resolution 'resolution'
      end
      b = klass.new('hello')
      expect(b.message).to eq("Problem:\n  this is a problem\nSummary:\n  summary\nResolution:\n  resolution\nContext:\n`hello`\n")
    end

    it 'when procs as hints' do
      klass = Class.new(described_class) do
        problem {|context| "problem #{context}" }
        summary {|context| "summary #{context}" }
        resolution {|context| "resolution #{context}" }
      end
      b = klass.new('hello')
      expect(b.message).to eq("Problem:\n  problem hello\nSummary:\n  summary hello\nResolution:\n  resolution hello\nContext:\n`hello`\n")
    end

    it "raising instance works" do
      expect {
        raise ExampleError.new('hello')
      }.to raise_error(ExampleError)
    end
    it "raising constant works" do
      expect {
        raise ExampleError
      }.to raise_error(ExampleError)
    end

    describe 'context' do
      it do
        b = described_class.new([1, 2, 3])
        expect(b.message).to eq("  - 1\n  - 2\n  - 3\n")
      end
      it do
        b = described_class.new(user_id: 1, name: 'John')
        expect(b.message).to eq("  - user_id: 1\n  - name: `John`\n")
      end
      it 'passing hash defaults to context' do
        b = described_class.new(user_id: 1, name: 'John')
        expect(b.message).to eq("  - user_id: 1\n  - name: `John`\n")
      end
      describe 'passing object responding to `to_s`' do
        class ExampleClass
          def to_s
            "This is and ExampleClass"
          end
        end

        it 'builds messge with the objects to_s string' do
          inst = ExampleClass.new
          b = described_class.new(inst)
          expect(b.message).to eq("#{inst.to_s}\n")
        end
      end
    end
  end
end
