module Erlash
  # ex:
  #    class HelloFormatter < TemplateFormatter
  #      def call
  #        output.puts object.greetings
  #      end
  #    end
  class TemplateFormatter

    def self.call(*args)
      new(*args).safe_call; nil
    end

    def self.format(formatter, object, opts = {})
      f = Formatter.new(formatter.registry)
      new(f, object, opts).format
    end

    attr_reader :object, :opts, :output, :formatter
    def initialize(formatter, object, opts = {})
      @object = object
      @opts = opts
      @formatter = formatter
      @output = formatter.output
      @executed = false
    end

    def format
      raise NotImplementedMethod
    end

    def safe_call
      return if @executed
      call
      @excuted = true
    end

    def format_elem(elem)
      Formatter.format(formatter, elem)
    end

    protected

    def call
      Fusu::Array.wrap(format).each do |e|
        output.puts e
      end
    end
  end
end
