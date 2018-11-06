require "erlash/version"
require "fusu"

module Erlash
  class << self
    def formatters
      {
        'Array' => ArrayFormatter,
        # 'Hash' => HashFormatter,
        # 'String' => StringFormatter
      }
    end

    def add_formatter_for(klass, formatter)
      formaters[klass.to_s] = formatter
    end

  end
end
require 'erlash/base'
require 'erlash/formatter'
require 'erlash/formatters'
