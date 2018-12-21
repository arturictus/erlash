require 'spec_helper'
module Erlash
  describe TriggerTemplate do
    context 'ENV test' do
      it 'raises error' do
        error_klass = Class.new()
        klass = Class.new(described_class) do
          problem do |context|
            context.no_method_for_it
          end
        end

        expect( klass.new())
      end
    end
  end
end
