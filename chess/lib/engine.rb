require_relative "board/board"
require_relative "board/setup_board"
require_relative "board/setup_display"
require_relative "game_mechanics"
require_relative "player/player"

board = Board.new
game = SetupBoard.new(board)
game.setup_board
display = SetupDisplay.new(board)
display.setup_display
# game.gameboard.print_board
display.gameboard.print_display
player1 = Player.new("Jack", "white")

loop do
  GameMechanics.select_piece(game)
  # game.gameboard.print_board

  # GameMechanics.get_king(board, player1.color)
  # GameMechanics.checkmate?(board)
  
  display.gameboard.print_display
end
