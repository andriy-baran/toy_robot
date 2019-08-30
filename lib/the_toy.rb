require 'pry'
require 'ostruct'
require 'tempfile'
require 'forwardable'
require 'the_toy/medium'
require 'the_toy/cell'
require 'the_toy/landscape'
require 'the_toy/terrain'
require 'the_toy/head'
require 'the_toy/processor'
require 'the_toy/robot'
require 'the_toy/space'
require 'the_toy/version'

module TheToy
  class Error < StandardError; end

  s = Space.new
  s.start_time
end
