require_relative "piece"

# Handles the creation of the Pawn chess piece

class Pawn < Piece
  attr_reader :move_set, :icon

  def initialize(color)
    super(color)
    @icon = set_icon
    @move_set = load_move_set
  end

  private

    def set_icon
      color == "white" ? "\u265F" : "\u2659"
    end

    def load_move_set
      self.color == "white" ? [1,0] : [-1,0]
    end

    def pawn_diagonal(gameboard, start_location)
      if color == "white"
        moves << [start_location[0] + 1, start_location[1] + 1]
        moves << [start_location[0] + 1, start_location[1] - 1]
      else
        moves << [start_location[0] - 1, start_location[1] - 1]
        moves << [start_location[0] - 1, start_location[1] + 1]
      end

      check_if_occupied?(gameboard)
    end

    def pawn_two_move_forward(gameboard, start_location)
      if color == "white"
        moves << [start_location[0] + 2, start_location[1]]
        moves << [start_location[0] + 2, start_location[1]]
      else
        moves << [start_location[0] - 2, start_location[1]]
        moves << [start_location[0] - 2, start_location[1]]
      end

      check_if_occupied?(gameboard)
    end
end