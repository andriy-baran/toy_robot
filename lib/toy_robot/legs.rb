class Legs

	attr_reader :position

	def initialize(x: nil, y: nil, size: 5)
		@position = Position.new(size: size, x: x, y: y)
		@map = Map.new(@position.size)
		update_map
	end

	def go(direction)
  	execute(direction) and update_map if @position.can_move?(direction)
	end

	def jump(x: nil, y: nil)
		@position = fetch_or_create(x: x, y: y)
		update_map 
	end

	private

	def execute(direction)
		#Ensure correct method calling
		if %w(north east south west).include?(direction)
			new_position = self.send(:"#{direction}")
			@position = fetch_or_create(new_position)
		end
	end

	def fetch_or_create(new_position)
		@map.has_pos?(new_position) ? get_existing_cell(new_position) : create_cell(new_position)
	end

	def create_cell(x: nil, y: nil)
		Position.new(size: @position.size, x: x, y: y)
	end

	def get_existing_cell(x: nil, y: nil)
		@map.fetch(x: x, y: y)
	end

	def update_map
		@map.add_cell(@position)
	end

	def north
		{ x: @position.x, y: @position.y + 1 }
	end

	def west
		{ x: @position.x - 1, y: @position.y }
	end

	def south
		{ x: @position.x, y: @position.y - 1 }
	end
	
	def east
		{ x: @position.x + 1, y: @position.y }
	end
	
end
