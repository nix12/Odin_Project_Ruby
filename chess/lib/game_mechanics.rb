module GameMechanics
  def self.select_piece(game)
    puts "Select chess location you would like to move"
    start_location = gets.chomp.split(",").flatten.map(&:to_i)

    puts "Where would you like to move to"
    end_location = gets.chomp.split(",").flatten.map(&:to_i)

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

  # def self.get_king(gameboard, player_color)
  #   king_locations = gameboard.find_by_piece("king")

  #   king_locations.find do |king| 
  #     gameboard.find(king).piece if gameboard.find(king).piece.color != player_color
  #   end
  # end

  # def self.checkmate?(gameboard, king)
  #   gameboard.board.each do |space|
  #     unless space.piece.nil?
  #       return true if space.piece.check?(gameboard)
  #     end
  #   end

  #   false
  # end
end
