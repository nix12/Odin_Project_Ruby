require_relative "board/board"
require_relative "board/setup_board"
require_relative "board/setup_display"
require_relative "game_mechanics"

board = Board.new
game = SetupBoard.new(board)
game.setup_board
display = SetupDisplay.new(board)
display.setup_display
# game.gameboard.print_board
display.gameboard.print_display

loop do
  GameMechanics.select_piece(game)
  # game.gameboard.print_board
  display.gameboard.print_display
end
