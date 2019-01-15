require_relative "board/board"
require_relative "board/setup_board"
require_relative "board/setup_display"

def select_piece(game)
  puts "Select chess location you would like to move"
  start_location = gets.chomp.split(",").flatten.map(&:to_i)
  
  puts "Where would you like to move to"
  end_location = gets.chomp.split(",").flatten.map(&:to_i)

  piece = game.gameboard.find(start_location).piece
  piece.move(game.gameboard, start_location, end_location)
end

board = Board.new
game = SetupBoard.new(board)
game.setup_board
display = SetupDisplay.new(board)
display.setup_display
display.gameboard.print_display

loop do
  select_piece(game)
  # game.gameboard.print_board
  display.gameboard.print_display
end



