require_relative 'lib/cells/east_cell'
require_relative 'lib/cells/south_east_cell'
require_relative 'lib/cells/north_east_cell'
require_relative 'lib/cells/west_cell'
require_relative 'lib/cells/south_west_cell'
require_relative 'lib/cells/north_west_cell'
require_relative 'lib/cells/south_cell'
require_relative 'lib/cells/north_cell'
require_relative 'lib/cells/middle_cell'
require_relative 'lib/toy_robot/position'
require_relative 'lib/toy_robot/map'
require_relative 'lib/toy_robot/legs'
require_relative 'lib/toy_robot/compass'
require_relative 'lib/toy_robot/robot'
require_relative 'lib/interpreter/parser'
require_relative 'lib/interpreter/scenario'

file = File.open('test.txt')
@scenario = Scenario.new(file)
@scenario.play
