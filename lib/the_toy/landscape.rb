module TheToy
  module Landscape
    def self.[](*ways)
      mod = Module.new do
        ways.each do |way|
          define_method(way) {}
        end
      end
    end
  end
end
