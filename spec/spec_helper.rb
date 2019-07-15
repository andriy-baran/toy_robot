require "bundler/setup"
require "the_toy"

module Helpers
  def capture_output
    fake_stdout = StringIO.new
    old_stdout = $stdout
    $stdout = fake_stdout
    yield
  ensure
    $stdout = old_stdout
    return fake_stdout.string
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Helpers
end
