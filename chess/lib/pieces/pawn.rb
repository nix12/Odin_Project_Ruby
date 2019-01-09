require_relative "piece"

# Handles the creation of the Pawn chess piece

class Pawn < Piece
  attr_reader :move_set, :icon

  def initialize(color)
    super(color)
    @icon = set_icon
    @move_set = [
      [1, 0]
    ].freeze
  end

  def set_icon
    color == "white" ? "\u265F" : "\u2659"
  end
end