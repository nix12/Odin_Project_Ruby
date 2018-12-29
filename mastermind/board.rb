class Board
	def initialize
		@color_bank = ['red', 'blue', 'black', 'green', 
										'purple', 'orange', 'yellow', 'gray',
										'pink', 'white', 'brown']
	end

	def set_board
		board = Array.new(5)
		
		while board.include?(nil)
			board.map! do |i|
				random_color = @color_bank[rand(10)] 
				unless board.include?(random_color)
					if i.nil? 
						i = random_color
					end
				end
			end
		end

		return board
	end

	def color_bank
		@color_bank
	end
end

# board = Board.new
# p board.set_board
# p board.color_bank
