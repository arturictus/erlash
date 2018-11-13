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

# first require template
require 'erlash/formatters/template_formatter'
# then the rest of formatters
Dir[File.expand_path("./formatters", __dir__) + "**/*rb"].each do |f|
  require f
end
