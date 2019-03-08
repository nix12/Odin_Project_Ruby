require_relative "board/board"
require_relative "board/setup_board"
require_relative "board/setup_display"
require_relative "game_mechanics"
require_relative "player/player"

# Player setup
player1 = GameMechanics.create_white_player
player2 = GameMechanics.create_black_player

# Board and Display setup
board = Board.new
game = SetupBoard.new(board)
game.setup_board
display = SetupDisplay.new(board)
display.setup_display

loop do
  GameMechanics.change_turn(player1, player2)
  
  # King locations
  my_king = GameMechanics.get_my_king(board, Player.active_user)
  enemy_king = GameMechanics.get_enemy_king(board, Player.active_user)
  
  # game.gameboard.print_board
  display.gameboard.print_display
  puts "#{ Player.active_user_name }'s turn"

  puts "Select chess location you would like to move"
  start_location = gets.chomp.split(",").flatten.map(&:to_i)

  puts "Where would you like to move to"
  end_location = gets.chomp.split(",").flatten.map(&:to_i)

  GameMechanics.select_piece(game, start_location, end_location)

  puts "#{ Player.inactive_user_name } is in check" if GameMechanics.in_check?(game, enemy_king) &&
    !GameMechanics.in_checkmate?(game, enemy_king)
  puts "#{ Player.inactive_user_name } is in checkmate" if GameMechanics.in_checkmate?(game, enemy_king)
end
