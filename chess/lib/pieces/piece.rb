# Handles the Piece parent class that all chess
# pieces will inherit from.

class Piece
  attr_accessor :color, :moves

  def initialize(color)
    @color = color
    @moves = []
  end

  def move(gameboard, start_location, end_location)
    if create_moves(start_location) && valid_moves(end_location)
      gameboard.find(end_location).piece = self
      gameboard.display[end_location[0]][end_location[1]] = icon

      gameboard.find(start_location).piece = nil
      gameboard.display[start_location[0]][start_location[1]] = "*"
    end
  end

  def create_moves(start_location)
    move_set.each do |move|
      x = start_location[0] + move[0] if start_location[0] + move[0] >= 0 && 
                                          start_location[0] + move[0] <= 7
      y = start_location[1] + move[1] if start_location[1] + move[1] >= 0 &&
                                          start_location[1] + move[1] <= 7
      moves << [x, y]
    end
  end

  def valid_moves(end_location)
    moves.reject! { |move| move.include?(nil) }
    
    if moves.include?(end_location)
      return true
    else
      puts "Move INVALID"
      return false
    end
  end
end