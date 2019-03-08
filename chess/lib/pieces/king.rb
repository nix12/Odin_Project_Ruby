require_relative "piece"

# Handles the creation of the King chess pieces
class King < Piece
  attr_reader :move_set, 
              :icon, 
              :checkmate, 
              :checkmate_bools, 
              :checkmate_result

  def initialize(color)
    super(color)
    @icon = set_icon
    @move_set = [
      [1, 1], [-1, 1], [-1, -1], [1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]
    ].freeze
    @checkmate = []
    @checkmate_bools = [
      method(:top),
      method(:upper_right), 
      method(:right), 
      method(:bottom_right),
      method(:bottom),
      method(:bottom_left),
      method(:left),
      method(:upper_left),
      method(:knight_check)
    ]
    @checkmate_result = []
  end

  def check(gameboard, king_location)
    checkmate_bools.map do |bool|
      checkmate.clear
      bool.call(gameboard, king_location)
    end
  end

  def checkmate?(gameboard, start_location)
    create_moves(start_location)
    moves.reject! { |move| move.include?(nil) }
    moves.reject! { |move| !gameboard.find(move).piece.nil? if gameboard.find(move).respond_to?(:piece) }

    moves.sort.each do |move|
      gameboard.find(move).piece = dup
      checkmate_result << gameboard.find(move).piece.check(gameboard, move)
      gameboard.find(move).piece = nil
    end
    
    bool = []

    if checkmate_result.length == 0
      bool << false
    else
      checkmate_result.each do |res|
        bool << res.any?
      end
    end

    moves.clear
    checkmate_result.clear
    bool.all?
  end

private

  def set_icon
    color == "white" ? "\u265A" : "\u2654"
  end

  def upper_right(gameboard, king_location)
    (king_location[0]..7).each.with_index do |range, i|
      checkmate << [king_location[0] + i, king_location[1] + i] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def upper_left(gameboard, king_location)
    (king_location[0]..7).reverse_each.with_index do |range, i|
      checkmate << [king_location[0] + i, king_location[1] - i] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def bottom_right(gameboard, king_location)
    king_location[0].downto(0).each.with_index do |range, i|
      checkmate << [king_location[0] - i, king_location[1] + i] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def bottom_left(gameboard,king_location)
    king_location[0].downto(0).reverse_each.with_index do |range, i|
      checkmate << [king_location[0] - i, king_location[1] - i] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def top(gameboard, king_location)
    (king_location[0]..7).each.with_index do |range, i|
      checkmate << [range, king_location[1]] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def bottom(gameboard, king_location)
    king_location[0].downto(0).each.with_index do |range, i|
      checkmate << [range, king_location[1]] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def right(gameboard, king_location)
    (king_location[1]..7).each.with_index do |range, i|
      checkmate << [king_location[0], range] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def left(gameboard, king_location)
    king_location[1].downto(0).each.with_index do |range, i|
      checkmate << [king_location[0], range] if !i.zero?
    end

    piece_in_path(gameboard)
  end

  def knight_check(gameboard, king_location)
    knight = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]

    knight.map do |move|
      checkmate << [move[0] + king_location[0], move[1] + king_location[1]]
    end

    piece_in_path(gameboard)
  end

  def valid_path
    checkmate.reject! do |location|
      location if location[0] < 0 || location[0] > 7 || location[1] < 0 || location[1] > 7
    end
  end

  def piece_in_path(gameboard)
    valid_path

    checkmate.each.with_index do |location, i|
      chain = []

      caller_locations.each do |caller|
        chain << caller.label
      end

      if (chain.include?("upper_right") ||
        chain.include?("upper_left") ||
        chain.include?("bottom_right") ||
        chain.include?("bottom_left")) &&
        (gameboard.find(location).piece.class.to_s == "Bishop" ||
        gameboard.find(location).piece.class.to_s == "Queen") &&
        gameboard.find(location).piece.color != color
        
        return true
      elsif (chain.include?("right") ||
        chain.include?("left") ||
        chain.include?("top") ||
        chain.include?("bottom")) &&
        (gameboard.find(location).piece.class.to_s == "Rook" ||
        gameboard.find(location).piece.class.to_s == "Queen") &&
        gameboard.find(location).piece.color != color
        
        return true
      elsif chain.include?("knight_check") &&
        gameboard.find(location).piece.class.to_s == "Knight" &&
        gameboard.find(location).piece.color != color
        
        return true
      end
    end

    false
  end
end
