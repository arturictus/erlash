require 'spec_helper'
describe Erlash::ErrorLogger do
  let(:malformed) do
    Class.new(Erlash::Base) do
      problem do
        raise "BOOM"
      end
    end
  end

  let(:error) do
    Class.new(Erlash::Base) do
      problem do
        "yep"
      end
    end
  end

  let(:skip) do
    Class.new(Erlash::Base) do
      def skip?; true end
    end
  end

  context "development" do
    before do
      allow(Erlash).to receive(:env).and_return('development')
    end
    it 'malformed is raised' do
      expect { described_class.call(malformed) }.to raise_error("BOOM")
    end
    it "wellformed error is logged" do
      expect { described_class.call(error) }.not_to raise_error
    end
  end
  context "other env, no test no development" do
    before do
      allow(Erlash).to receive(:env).and_return('other')
    end
  end

end