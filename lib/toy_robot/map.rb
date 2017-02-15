class Map

	def initialize(size)
		@size = size
		@cells = {}
	end

	def add_cell(cell)
		return if @cells.has_key?(cell.name)
		@cells[cell.name] = cell
	end

	def has_pos?(x: nil, y: nil)
		return if x.nil? || y.nil?
		@cells.has_key?(Position.generate_name(x, y))
	end

	def fetch(x: nil, y: nil)
		return if x.nil? || y.nil?
		@cells[Position.generate_name(x, y)]
	end
	
end