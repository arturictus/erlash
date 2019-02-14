require 'spec_helper'
describe Erlash::ErrorLogger do

  let(:error) do
    Class.new(Erlash::Base) do
      problem do
        "yep"
      end
    end
  end

  context "execute loggs error" do
    before do
      allow(Erlash).to receive(:env).and_return('development')
    end
    it "wellformed error is logged" do
      expect(Erlash.logger).to receive(:error)
      expect { described_class.call(error) }.not_to raise_error
    end
  end
  describe "callback" do
    class CallbackClass
      def self.call(error, trigger)
        # do something here
      end
    end
    class AnError < Erlash::Base
    end

    context 'after callback is set' do
      before do
        allow(Erlash).to receive(:env).and_return('development')
        allow(Erlash).to receive(:after_logging).and_return CallbackClass
      end
      it do
        expect(CallbackClass).to receive(:call).with(AnError, instance_of(described_class))
        Erlash::ErrorLogger.call(AnError)
      end
    end
  end
end
