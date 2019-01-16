# Handles the Piece parent class that all chess
# pieces will inherit from.

class Piece
  attr_accessor :color, :moves

  def initialize(color)
    @color = color
    @moves = []
  end

  def add_piece(gameboard, start_location, end_location)
    if create_moves(start_location) && valid_moves(end_location)
      gameboard.find(end_location).piece = self
      gameboard.display[end_location[0]][end_location[1]] = icon
    end
  end

  def remove_piece(gameboard, start_location, end_location)
    if create_moves(start_location) && valid_moves(end_location)
      gameboard.find(start_location).piece = nil
      gameboard.display[start_location[0]][start_location[1]] = "*"
    end
  end

  def clear_moves
    moves.clear
  end

  def move(gameboard, start_location, end_location)
    if self.class.to_s == "Bishop" || self.class.to_s == "Queen" &&
      (start_location[0] - end_location[0] > 1 || 
      start_location[0] - end_location[0] < -1 || 
      start_location[1] - end_location[1] > 1 || 
      start_location[1] - end_location[1] < -1)
      
      check = ranged_diagonal(gameboard, start_location, end_location)

      add_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    end

    if self.class.to_s == "Rook" || self.class.to_s == "Queen" && 
      (start_location[0] - end_location[0] > 1 || 
      start_location[0] - end_location[0] < -1)


      check = ranged_vertical(gameboard, start_location, end_location)

      add_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    end

    if self.class.to_s == "Rook" || self.class.to_s == "Queen" && 
      (start_location[1] - end_location[1] > 1 || 
      start_location[1] - end_location[1] < -1)

      check = ranged_horizontal(gameboard, start_location, end_location)

      add_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    end

    clear_moves
  end

  def create_moves(start_location)
    move_set.each do |move|
      if start_location[0] + move[0] >= 0 && start_location[0] + move[0] <= 7
        x = start_location[0] + move[0]
      end

      if start_location[1] + move[1] >= 0 && start_location[1] + move[1] <= 7
        y = start_location[1] + move[1]
      end

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

  def ranged_vertical(gameboard, start_location, end_location)
    if start_location[0] > end_location[0]
      start_location[0].downto(end_location[0]).each.with_index do |range, i|
        moves << [range, start_location[1]] unless i.zero?
      end
    else
      (start_location[0]..end_location[0]).each.with_index do |range, i|
        moves << [range, start_location[1]] unless i.zero?
      end
    end

    moves.each do |move|
      return true if check_if_occupied(gameboard, move)
    end

    false
  end

  def ranged_horizontal(gameboard, start_location, end_location)
    if start_location[1] > end_location[1]
      start_location[1].downto(end_location[1]).each.with_index do |range, i|
        moves << [start_location[0], range] unless i.zero?
      end
    else
      (start_location[1]..end_location[1]).each.with_index do |range, i|
        moves << [start_location[0], range] unless i.zero?
      end
    end

    moves.each do |move|
      return true if check_if_occupied(gameboard, move)
    end

    false
  end

  def ranged_diagonal(gameboard, start_location, end_location)
    if start_location[0] > end_location[0] && start_location[1] > end_location[1]
      start_location[0].downto(end_location[0]).reverse_each.with_index do |range, i|
        moves << [start_location[0] - i, start_location[1] - i] unless i.zero?
      end
    elsif start_location[0] < end_location[0] && start_location[1] > end_location[1]
      (start_location[0]..end_location[0]).reverse_each.with_index do |range, i|
        moves << [start_location[0] + i, start_location[1] - i] unless i.zero?
      end
    elsif start_location[0] > end_location[0] && start_location[1] < end_location[1]
      start_location[0].downto(end_location[0]).each.with_index do |range, i|
        moves << [start_location[0] - i, start_location[1] + i] unless i.zero?
      end
    else
      (start_location[0]..end_location[0]).each.with_index do |range, i|
        moves << [start_location[0] + i, start_location[1] + i] unless i.zero?
      end
    end

    moves.each do |move|
      return true if check_if_occupied(gameboard, move)
    end

    false
  end

  def check_if_occupied(gameboard, location)
    if !gameboard.find(location).piece.nil?
      puts "Illegal movement"
      true
    else
      false
    end
  end
end
