require "bundler/setup"
require "erlash"
require 'pry'
require 'erlash/testing'

Dir[File.expand_path("./support/**/*.rb", __dir__)].each { |f| require f }
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  config.include Erlash::Testing

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.expose_dsl_globally = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Erlash::Testing.messages_path = File.expand_path('./messages', __dir__)
