class Parser

	def initialize(file)
    @tokens = file.readlines.map(&:chomp)
    @actions = create_actions
  end

  def actions
  	clear_invalid_actions
  end

  private
	
	def create_actions
		@tokens.map do |token|
			if token.match(/PLACE\s+\d+\s*\,\d+\s*\,[\w]{4,5}/)
				action_name, x, y, facing = token.scan(/PLACE|\d+|\d+|[\w]{4,5}/)
				if x.to_i < 0 || y.to_i < 0 || x.to_i >= Scenario::WORLD_SIZE || y.to_i >= Scenario::WORLD_SIZE || !%w(NORTH EAST WEST SOUTH).include?(facing)
					nil
				else
					token.scan(/PLACE|\d+|\d+|[\w]{4,5}/)
				end
			elsif token.match(/MOVE/)
				'move'
			elsif token.match(/REPORT/)
				'report' 
			elsif token.match(/LEFT/)
				'left'
			elsif token.match(/RIGHT/)
				'right'
			end
		end.compact
	end

	# I want to get actions list begins from "PLACE" action
	def clear_invalid_actions
		@actions = @actions.drop(detect_first_place_action)
	end

	# Just for clarifying names of function and her result 
	# alias_method :valid_command_queue, :clear_invalid_actions

	# Algorithm may change within implementing new features
	# So it better to hold it separately 
	def detect_first_place_action
		@actions.index{|action| action.is_a? Array}
	end
end