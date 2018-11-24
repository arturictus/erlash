require "erlash/version"
require "fusu"
require "logger"

module Erlash
  class << self
    attr_accessor :after_logging_error, :skip_logging, :raise_malformed_error
    attr_writer :logger, :env

    def formatters
      @formatters ||= Formatters.new
    end

    def logger
      @logger ||= Logger.new(STOUT)
    end

    def config
      yield(self)
    end

    def env
      @env || ENV['RAILS_ENV'] || ENV['RACK_ENV'] || ENV['ENV'] || 'development'
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
require 'erlash/error_logger'

Erlash.formatters.tap do |f|
  f.register Array, Erlash::ArrayFormatter
  f.register Hash, Erlash::HashFormatter
  f.register String, Erlash::StringFormatter
  f.register Erlash::Context, Erlash::ContextFormatter
  f.register Erlash::MainArray, Erlash::MainArrayFormatter
  f.register Erlash::MainHash, Erlash::MainHashFormatter
  f.register Erlash::Tip, Erlash::TipFormatter
end
