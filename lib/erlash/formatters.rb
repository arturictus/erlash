module Erlash
  class Formatters
    include Enumerable

    def find(klass)
      db[klass]
    end

    def register(klass, val, opts = {})
      db[klass] = val
    end

    def each(&block)
      db.each(&block)
    end

    private

    def db
      @db ||= Fusu::HashWithIndifferentAccess.new
    end
  end
end

require 'erlash/formatters/template_formatter'
require 'erlash/formatters/array_formatter'
require 'erlash/formatters/hash_formatter'
require 'erlash/formatters/tip_formatter'
