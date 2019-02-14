require 'spec_helper'
module Erlash
  class ErrorRaiser::AnError < Erlash::Base
    problem do
      'yep'
    end
  end
  class ErrorRaiser::AMalformedError < Erlash::Base
    problem do
      raise "BOOM"
    end
  end

  describe ErrorRaiser do

    context "execute loggs error" do
      before do
        allow(Erlash).to receive(:env).and_return('development')
      end
      it "wellformed error is raised as expected" do
        expected_message('error_raiser_an_error') do |msg|
          expect {
            described_class.call(ErrorRaiser::AnError)
          }.to raise_error(ErrorRaiser::AnError).with_message(msg)
        end
      end
    end
  end
end
