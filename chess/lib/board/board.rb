# Handles initializing, building and displaying chess board.
# Also, provides ability to find specifc spaces in the chess board.

class Board
  attr_accessor :board, :display

  def initialize
    @board = []
    @display = []
  end

  def self.x_coordinate
    (0..7).to_a
  end

  def self.y_coordinate
    (0..7).to_a
	end

  def find(value)
    board.detect { |node| node.location == value }
  end

  def build_board
    Board.x_coordinate.each do |x|
      Board.y_coordinate.each do |y|
        left = x - 1 unless x == 0
        right = x + 1 unless x == 7
        up = y + 1 unless y == 7
        down = y - 1 unless y == 0

        neighbors = []
        neighbors << [left, y] unless left.nil?
        neighbors << [right, y] unless right.nil?
        neighbors << [x, up] unless up.nil?
        neighbors << [x, down] unless down.nil?
        node = Space.new([x, y], neighbors)

        board << node
      end
    end
  end

  def print_board
    pp board
  end

  def build_display
    Board.x_coordinate.each.with_index do |x, i|
      row = []
      display << row

      Board.y_coordinate.each.with_index do |y, j|
        row << "*"
      end
    end
  end

  def print_display
    display.reverse_each { |row| p row.join(" ") }
  end
end

# Stores data for each individual space.

class Space
  attr_reader :neighbors
  attr_accessor :location, :piece, :visited, :parent

  def initialize(location, neighbors)
    @location = location
    @neighbors = neighbors
    @parent = nil
    @piece = nil
    @visited = false
  end
end
