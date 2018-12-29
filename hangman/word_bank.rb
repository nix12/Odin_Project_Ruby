def word_list
	words = Array.new
	contents = File.open '5desk.txt'
		contents.each do |word|
		words << word.chop 
	end

	return words
end

def random_word
	words = word_list
	word = words[rand(words.length)]

	if word.length >= 5 && word.length <= 12 
		return word
	else
		random_word
	end
end