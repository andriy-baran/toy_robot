class Compass

	def initialize(facing)
		@ways = %w(north east south west)
		set(facing)
	end

	def left
		rotate_left.first
	end

	def right
		rotate_right.first
	end

	def set(facing)
		rotate_left until @ways.first == facing
	end

	private

	def rotate_left
		@ways.unshift(@ways.pop)
	end

	def rotate_right
		@ways.push(@ways.shift)
	end

end