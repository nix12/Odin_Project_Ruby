def search(string)
  string = string.downcase.downcase
  string_array =  string.split(' ')
  dictionary = ["below","down","go","going",
	  "horn","how","howdy","it","i","low","own","part",
	  "partner","sit", "below"]
	matches = {}  
  #puts string

string_array.each do |str|
  dictionary.each do |word|
    if str.include?(word)
      if matches.key?(word)
        matches[word] += 1
        #puts "***"
      else
        #puts "else"
        matches[word] = 1
      end
    end 
  end
end
 puts matches
end
 
#"Howdy partner, sit down! How's it going?"
puts search("Howdy partner, sit sit down! How's it going?")



=begin
def substring(sentence)
 # sentence = sentence.split(' ')
  #puts sentence


  output = []
  sentence.split(' ').map do |word|
    #puts word, '---'
      output << search(word)
      
      end
end

def search(string)
  string = string.downcase
  dictionary = ["below","down","go","going",
	  "horn","how","howdy","it","i","low","own","part",
	  "partner","sit", "below"]
	matches = {}  
	  
  dictionary.each do |word|
    if string.include?(word)
      #puts word
      if matches.key?(word)
      puts '****'
        matches[word] += 1
      else
        matches[word] = 1
      end
    end 
  end
  matches
end

#"Howdy partner, sit down! How's it going?"
substring("Howdy partner, sit down! How's it going?")
=end
