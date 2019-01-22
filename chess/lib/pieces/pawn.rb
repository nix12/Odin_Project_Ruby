require_relative "piece"

# Handles the creation of the Pawn chess piece

class Pawn < Piece
  attr_reader :move_set, :icon

  def initialize(color)
    super(color)
    @icon = set_icon
    @move_set = load_move_set
  end

  def set_icon
    color == "white" ? "\u265F" : "\u2659"
  end

  def load_move_set
    self.color == "white" ? [[1, 0]] : [[-1, 0]]
  end
end