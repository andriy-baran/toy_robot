require 'pry'
require 'ostruct'
require 'forwardable'
require_relative './lib/medium'
require_relative './lib/world/cell'
require_relative './lib/world/landscape'
require_relative './lib/world/terrain'
require_relative './lib/toy_robot/head'
require_relative './lib/toy_robot/processor'
require_relative './lib/toy_robot/robot'
require_relative './lib/world/space'

s = Space.new
s.start_time
