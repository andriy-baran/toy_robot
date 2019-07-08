class Processor
  attr_accessor :mediator

  def initialize
    @commands_stream = File.open('test.txt').each_line
  end

  def run
    loop do
      begin
        parse(@commands_stream.next.chomp)
      rescue StopIteration => e
        break
      end
    end
  end

  private

  def parse(command)
    if matches = command.match(/PLACE\s+(\d+)\s*\,(\d+)\s*\,([\w]{4,5})/)
      x, y, facing = *matches.captures
      mediator.place(x.to_i, y.to_i, facing.downcase.to_sym)
    elsif command.match(/MOVE/)
      mediator.move
    elsif command.match(/REPORT/)
      mediator.report
    elsif command.match(/LEFT/)
      mediator.left
    elsif command.match(/RIGHT/)
      mediator.right
    end
  end

  attr_reader :commands_queue
end
