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

Erlash.formatters.tap do |f|
  f.register Array, Erlash::ArrayFormatter
  f.register Hash, Erlash::HashFormatter
  f.register String, Erlash::StringFormatter
  f.register Erlash::Context, Erlash::ContextFormatter
  f.register Erlash::MainArray, Erlash::MainArrayFormatter
  f.register Erlash::MainHash, Erlash::MainHashFormatter
  f.register Erlash::Tip, Erlash::TipFormatter
end
