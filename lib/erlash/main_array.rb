module Erlash
  class MainArray < Array
    def self.build(ary)
      ary.each_with_object(self.new) do |e, o|
        o << e
      end
    end
  end
end
