require './player.rb'
require './board.rb'

puts 'Welcome to Mastermind'

puts 'How many players will be playing (1 or 2)'
player_number = gets.chomp.to_i

if player_number ==  1
	puts 'Please enter your name: '

	player_1 = gets.chomp
	guesser = Player.new(name: player_1)

	puts "Hello #{ guesser.name[:name] }"
	puts 'The goal of the game is to guess the correct combination of colors'
	puts '********************************'
	board = Board.new
	game = board.set_board
else
	puts 'Player 1 please ender your your name: '
	player_1 = gets.chomp

	puts 'Player 2 please ender your your name: '
	player_2 = gets.chomp

	guesser = Player.new(name: player_1)
	creator = Player.new(name: player_2)

	board = Board.new

	puts "#{ creator.name[:name] }, please pick 5 colors"
	print board.color_bank

	game = Array.new(5)

	game.map! do |i|
		i = gets.chomp
	end
end


turn = 10
while turn > 0 do
	win = Array.new(5)
	feedback = []
	puts 'Guess 5 colors.'
	win.map! do |i|
		i = gets.chomp
	end

	combo = Enumerator.new do |yielder|
		game.each { |value1| yielder.yield value1 }
	end


	win.each do |value2|
		if value2 == combo.next
		  feedback << 'match'
		else
			feedback << 'not match'
		end
		
	end
	turn -= 1
	p feedback
	if game == win
		puts "You've correctly guessed the right combination of colors, you win"
		break
	elsif turn == 0
		puts 'You Lose!'
	end
end

