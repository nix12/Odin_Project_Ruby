class Knight
  attr_accessor :queue, :path

  KNIGHT_MOVES = [
    [1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]
  ].freeze

  def initialize
    @queue = []
    @path = []
  end

  def move(board, start_location, end_location)
    node = board.find(start_location)
    node.visited = true
    queue << node

    until queue.empty?
      current = queue.shift

      KNIGHT_MOVES.each do |move|
        next_node = board.find(
          [current.location[0] + move[0], current.location[1] + move[1]]
        )
        next if next_node.nil?

        next unless next_node.visited == false

        next_node.parent = current.location
        queue << next_node
        next_node.visited = true
        return calculate_path(board, start_location) if next_node.location == end_location
      end
    end
  end

  def calculate_path(board, start_location)
    node = queue.pop

    until start_location == node.location
      path << node
      node = board.find(node.parent)
    end

    path << board.find(start_location)
    path
  end

  def print_path
    puts "Your knight's path is: "
    path.reverse_each { |node| p node.location }
  end
end
