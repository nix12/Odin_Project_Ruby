require_relative 'board.rb'
require_relative 'knight.rb'

gameboard = Board.new
gameboard.build_board
gameboard.build_display
gameboard.print_display
knight = Knight.new

puts "Enter coordinates in 'x, y' format"
puts "Please give the Knight's starting location"
start_location = gets.chomp.split(",").flatten.map(&:to_i)
p start_location
puts "Please give Knight's end location"
end_location = gets.chomp.split(",").flatten.map(&:to_i)
p end_location

knight.move(gameboard, start_location, end_location)

knight.print_path.reverse_each.with_index do |space, i|
  if knight.print_path.reverse.length - 1 == i
    gameboard.display[space.location[0]][space.location[1]] = "\u265E"
  else
    gameboard.display[space.location[0]][space.location[1]] = i
  end
end

gameboard.print_display
