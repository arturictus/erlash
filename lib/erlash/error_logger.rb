require_relative 'trigger_template'
module Erlash
  class ErrorLogger < TriggerTemplate
    def execute
      if log?
        logger.error("[#{error.class}]\n#{error}")
        after_callback
      end
    end

    def after_callback
      return unless Erlash.after_logging_error
      Erlash.after_logging_error.call(error, self)
    rescue => e
      raise(e) if raise_malformed_error?
      logger.warn("[ErlashExt] `config.after_logging_error` raising exeption for: { class: #{klass}, context: #{context} }") if warn_malformed_error?
    end
  end
end
