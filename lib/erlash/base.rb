module Erlash
  class Base < StandardError
    class << self
      attr_accessor :hint, :formater
    end
  end
end
