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
      gameboard.display[end_location[0]][end_location[1]] = icon
      gameboard.find(end_location).piece = self
    end
  end

  def remove_piece(gameboard, start_location, end_location)
    if create_moves(start_location) && valid_moves(end_location)
      gameboard.display[start_location[0]][start_location[1]] = "*"
      gameboard.find(start_location).piece = nil
    end
  end

  def replace_piece(gameboard, start_location, end_location)
    if create_moves(start_location) && valid_moves(end_location)
      gameboard.display[end_location[0]][end_location[1]] = "*"
      gameboard.find(end_location).piece = nil

      gameboard.display[end_location[0]][end_location[1]] = icon
      gameboard.find(end_location).piece = self
    end
  end

  def take_piece(gameboard, start_location, end_location)
    if (self.class.to_s == "Bishop" || self.class.to_s == "Queen") &&
      ((start_location[0] - end_location[0] > 1 ||
      start_location[0] - end_location[0] < -1) &&
      (start_location[1] - end_location[1] > 1 ||
      start_location[1] - end_location[1] < -1))

      check = ranged_diagonal(gameboard, start_location, end_location)

      replace_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    elsif (self.class.to_s == "Rook" || self.class.to_s == "Queen") &&
      (start_location[0] - end_location[0] > 1 ||
      start_location[0] - end_location[0] < -1)

      check = ranged_vertical(gameboard, start_location, end_location)

      replace_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    elsif (self.class.to_s == "Rook" || self.class.to_s == "Queen") &&
      (start_location[1] - end_location[1] > 1 ||
      start_location[1] - end_location[1] < -1)

      check = ranged_horizontal(gameboard, start_location, end_location)

      replace_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    elsif self.class.to_s == "Pawn" &&
      ((start_location[0] - end_location[0] == 1 ||
        start_location[0] - end_location[0] == -1) &&
        (start_location[1] - end_location[1] == 1 ||
        start_location[1] - end_location[1] == -1))

      check = pawn_diagonal(gameboard, start_location)

      replace_piece(gameboard, start_location, end_location) if check
      remove_piece(gameboard, start_location, end_location) if check
    else
      replace_piece(gameboard, start_location, end_location)
      remove_piece(gameboard, start_location, end_location)
    end

    moves.clear
  end

  def move(gameboard, start_location, end_location)
    if (self.class.to_s == "Bishop" || self.class.to_s == "Queen") &&
      ((start_location[0] - end_location[0] > 1 ||
      start_location[0] - end_location[0] < -1) &&
      (start_location[1] - end_location[1] > 1 ||
      start_location[1] - end_location[1] < -1))

      check = ranged_diagonal(gameboard, start_location, end_location)

      add_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    elsif (self.class.to_s == "Rook" || self.class.to_s == "Queen") &&
      (start_location[0] - end_location[0] > 1 ||
      start_location[0] - end_location[0] < -1)

      check = ranged_vertical(gameboard, start_location, end_location)

      add_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    elsif (self.class.to_s == "Rook" || self.class.to_s == "Queen") &&
      (start_location[1] - end_location[1] > 1 ||
      start_location[1] - end_location[1] < -1)

      check = ranged_horizontal(gameboard, start_location, end_location)

      add_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    elsif self.class.to_s == "Pawn" &&
      (start_location[0] - end_location[0] == 2 ||
      start_location[0] - end_location[0] == -2)
      
      check = pawn_two_moves_forward(gameboard, start_location)

      add_piece(gameboard, start_location, end_location) unless check
      remove_piece(gameboard, start_location, end_location) unless check
    else
      add_piece(gameboard, start_location, end_location)
      remove_piece(gameboard, start_location, end_location)
    end

    moves.clear
  end

  def create_moves(start_location)
    move_set.each do |move|
      if start_location[0] + move[0] >= 0 && start_location[0] + move[0] <= 7
        y = start_location[0] + move[0]
      end

      if start_location[1] + move[1] >= 0 && start_location[1] + move[1] <= 7
        x = start_location[1] + move[1]
      end

      moves << [y, x]
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

    chain = []

    caller_locations.each do |caller|
      chain << caller.label
    end

    if chain.include?("in_checkmate?")
      false
    else
      check_if_occupied?(gameboard)
    end
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

    chain = []

    caller_locations.each do |caller|
      chain << caller.label
    end

    if chain.include?("in_checkmate?")
      false
    else
      check_if_occupied?(gameboard)
    end
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

    chain = []

    caller_locations.each do |caller|
      chain << caller.label
    end

    if chain.include?("in_checkmate?")
      return false
    else
      check_if_occupied?(gameboard)
    end
  end

  def check_if_occupied?(gameboard)
    valid = []

    moves.each do |move|
      valid << move if gameboard.find(move).respond_to?(:piece) && gameboard.find(move).piece.respond_to?(:color) &&
        gameboard.find(move).piece.color != color
      opponent_first_piece = nil
      opponent_first_piece = gameboard.find(valid.first).piece.color if valid.first != nil
      blocking_piece = gameboard.find(move).piece.color if gameboard.find(move).respond_to?(:piece) && gameboard.find(move).piece != nil
      valid_first_occupied = !gameboard.find(move).piece.nil? if gameboard.find(move).respond_to?(:piece) && !(move == valid.first)

      if (opponent_first_piece != color && valid_first_occupied) ||
        (blocking_piece == color && !gameboard.find(move).piece.nil?)

        puts "Illegal movement"
        return true
      end
    end

    false
  end
end
