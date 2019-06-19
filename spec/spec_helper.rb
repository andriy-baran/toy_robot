require 'rspec'
require_relative '../lib/cells/east_cell'
require_relative '../lib/cells/south_east_cell'
require_relative '../lib/cells/north_east_cell'
require_relative '../lib/cells/west_cell'
require_relative '../lib/cells/south_west_cell'
require_relative '../lib/cells/north_west_cell'
require_relative '../lib/cells/south_cell'
require_relative '../lib/cells/north_cell'
require_relative '../lib/cells/middle_cell'
require_relative '../lib/toy_robot/position'
require_relative '../lib/toy_robot/map'
require_relative '../lib/toy_robot/legs'
require_relative '../lib/toy_robot/compass'
require_relative '../lib/toy_robot/robot'
require_relative '../lib/interpreter/parser'
require_relative '../lib/interpreter/scenario'

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
