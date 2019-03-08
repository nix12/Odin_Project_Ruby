module GameMechanics
  def self.select_piece(game, start_location, end_location)
    start_piece = game.gameboard.find(start_location).piece
    destination_piece = game.gameboard.find(end_location).piece

    if destination_piece.respond_to?(:color)
      if destination_piece.color != start_piece.color
        start_piece.take_piece(game.gameboard, start_location, end_location)
      else
        start_piece.move(game.gameboard, start_location, end_location)
      end
    else
      start_piece.move(game.gameboard, start_location, end_location)
    end
  end

  def self.create_white_player
    puts "Enter first players name: "
    new_player = gets.chomp.to_s

    Player.new(new_player, "white")
  end

  def self.create_black_player
    puts "Enter second players name: "
    new_player = gets.chomp.to_s

    Player.new(new_player, "black")
  end

  def self.change_turn(player_1, player_2)
    if !player_1.active && !player_2.active
      player_1.active = true
    elsif player_1.active
      player_1.active = false
      player_2.active = true
    elsif player_2.active
      player_1.active = true
      player_2.active = false
    end
  end

  def self.get_my_king(gameboard, player)
    king_locations = gameboard.find_by_piece("king")

    king_locations.find do |king|
      gameboard.find(king).piece if gameboard.find(king).piece.color == player.color
    end
  end

  def self.get_enemy_king(gameboard, player)
    king_locations = gameboard.find_by_piece("king")

    king_locations.find do |king|
      gameboard.find(king).piece if gameboard.find(king).piece.color != player.color
    end
  end

  def self.in_check?(game, enemy_king)
    game.gameboard.find(enemy_king).piece.check(game.gameboard, enemy_king).any?
  end

  def self.in_checkmate?(game, enemy_king)
    king = game.gameboard.find(enemy_king).piece.check(game.gameboard, enemy_king).any?
    possible_moves = game.gameboard.find(enemy_king).piece.checkmate?(game.gameboard, enemy_king)
    
    [king, possible_moves].all?
  end
end
