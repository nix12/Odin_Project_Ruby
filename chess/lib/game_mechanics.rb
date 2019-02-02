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
end
