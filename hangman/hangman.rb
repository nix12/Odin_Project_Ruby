require './word_bank'
require 'yaml'

class Hangman
	def initialize
		@turn = 20
		@correct_word = random_word	
		@blanks = @correct_word.split('').each do |letter|
			letter.gsub!(letter, '_')
		end	
	end

	def win?(blanks, correct_word)
		if blanks == @correct_word.split('')
			puts "You guessed #{ @correct_word }, You win"
		end
	end

	def play
		while @turn > 0
			puts 'Type save at anytime to save your game'
			puts "Pick a letter (case-sensitive) - #{ @turn } turns left"
			guess_letter = gets.chomp 

			if guess_letter == 'save'
				save_game
				break
			end

			@correct_word.split('').each_with_index do |letter, i|
				if letter == guess_letter
					@blanks[i] = guess_letter
				end	
			end

			win?(@blanks, @correct_word)
			break if @blanks == @correct_word.split('')

			p @blanks
			@turn -= 1
		end
		puts "You lose, the correct word was #{ @correct_word }" if @turn == 0
	end
end

def save_game
	Dir.mkdir('save') unless Dir.exist? 'save'
	filename = "save/game.yaml"
	File.open(filename, 'w') do |file|
		file.puts YAML.dump(self)
	end
end

def load_game
		content = File.open('save/game.json', 'r') { |file| file.read }
		YAML.load(content)
end

puts 'Press enter to start new game'
puts 'Type load to load saved game'
guess_letter = gets.chomp

if guess_letter == 'load'
	hangman = load_game
	hangman.play
else
	hangman = Hangman.new
	hangman.play
end