module Erlash

  class TriggerTemplate
    def self.call(*args)
      new(*args).call
    end

    attr_reader :klass, :context
    def initialize(klass, context = {})
      @klass = klass
      @context = context
    end

    def call
      return unless trigger?
      execute
    end

    def execute
      raise NotImplementedError
    end

    def trigger?
      return false if error == :malformed
      return false if skip?
      true
    end

    def skip?
      error.skip?
    rescue => e
      raise(e) if raise_malformed_error?
      logger.warn("[Erlash] skip on error: #{klass} raises error with context: #{context}. Please fix it.") if warn_malformed_error?
      false
    end

    def skip_logging?
      if Erlash.skip_logging
        Erlash.skip_logging.call(self)
      else
        Erlash.env.to_s == 'test'
      end
    end

    def raise_malformed_error?
      if Erlash.raise_malformed_error
        Erlash.raise_malformed_error.call(self)
      else
        Erlash.env.to_s == 'test' || Erlash.env.to_s == 'development'
      end
    end

    def log?
      !skip_logging?
    end

    private

    def warn_malformed_error?
      !raise_malformed_error?
    end

    def logger
      Erlash.logger
    end

    def error
      @error ||= initialize_error
    end

    def initialize_error
      klass.new(context)
    rescue => e
      raise(e) if raise_malformed_error?
      logger.warn("[ErlashExt] malformed error: { class: #{klass}, context: #{context}}") if warn_malformed_error?
      :malformed
    end
  end
end
