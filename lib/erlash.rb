require "erlash/version"
require "fusu"

module Erlash
  class << self
    def formatters
      @formatters ||= Formatters.new
    end
  end
end
require 'erlash/tip'
require 'erlash/context'
require 'erlash/base'
require 'erlash/main_array'
require 'erlash/main_hash'
require 'erlash/formatter'
require 'erlash/formatters'
