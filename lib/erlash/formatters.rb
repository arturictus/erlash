module Erlash
  class Formatters
    def initialize
      @db = Fusu::HashWithIndifferentAccess.new
    end

    def find(klass)
      db[Klass]
    end
  end
end

require 'erlash/formatters/array_formatter'
