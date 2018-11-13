module Erlash
  class MainHash < Hash
    def self.build(hash)
      hash.each_with_object(self.new) do |(k, v), o|
        o[k] = v
      end
    end
  end
end
