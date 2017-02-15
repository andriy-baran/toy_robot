class Scenario
	WORLD_SIZE = 5

	def initialize(file)
		@actions = Parser.new(file).actions
		@toy_robot = create_robot
	end

	def play
		@actions.each do |action|
			if action.is_a?(Array)
				action_name, x, y, facing = action
				@toy_robot.place(x, y, facing)
			else
				@toy_robot.public_send(:"#{action}") if @toy_robot.respond_to?(:"#{action}")
			end
		end
	end

	def create_robot
		action_name, x, y, facing = @actions.shift
		Robot.new(x: x.to_i, y: y.to_i, facing: facing.downcase, size: WORLD_SIZE)
	end
	
	
end