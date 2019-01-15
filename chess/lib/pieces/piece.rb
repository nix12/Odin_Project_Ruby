# Handles the Piece parent class that all chess
# pieces will inherit from.

class Piece
  attr_accessor :color, :moves

  def initialize(color)
    @color = color
    @moves = []
  end

  def add_piece(gameboard, location)
    gameboard.find(location).piece = self
    gameboard.display[location[0]][location[1]] = icon
  end

  def remove_piece(gameboard, location)
    gameboard.find(location).piece = nil
    gameboard.display[location[0]][location[1]] = "*"
  end

  def clear_moves
    moves.clear
  end

  def move(gameboard, start_location, end_location)
    if start_location[0] - end_location[0] > 1 || start_location[0] - end_location[0] < -1
      check = ranged_vertical(gameboard, start_location, end_location)

      if create_moves(start_location) && valid_moves(end_location)
        add_piece(gameboard, end_location) unless check
        remove_piece(gameboard, start_location) unless check
      end
    elsif start_location[1] - end_location[1] > 1 || start_location[1] - end_location[1] < -1
      check = ranged_horizontal(gameboard, start_location, end_location)

      if create_moves(start_location) && valid_moves(end_location)
        add_piece(gameboard, end_location) unless check
        remove_piece(gameboard, start_location) unless check
      end
    else
      add_piece(gameboard, end_location)
      remove_piece(gameboard, start_location)
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

  def ranged_diagonal

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
