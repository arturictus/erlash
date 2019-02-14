require_relative 'trigger_template'
module Erlash
  class ErrorLogger < TriggerTemplate
    def execute
      return unless log?
      logger.error("[#{error.class}]\n#{error}")
      after_callback
    end

    def after_callback
      return unless Erlash.after_logging
      Erlash.after_logging.call(error, self)
    rescue => e
      raise(e) if raise_malformed_error?
      logger.warn("[Erlash] `config.after_logging` raising exeption for: { class: #{klass}, context: #{context} }") if warn_malformed_error?
    end
  end
end
