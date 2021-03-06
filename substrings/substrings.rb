def substring(sentence)
 output = []
  sentence.split(' ').map do |word|
      output << search(word)  
  end
  count = {}
  output.each do |index|
    index.each do |key, value|
      if count.include?(key)
        count[key] += 1
      else
        count[key] = 1
      end
    end
  end
  print count.sort_by { |k, v| k }
end

def search(string)
  string = string.downcase
  dictionary = ["below","down","go","going",
	  "horn","how","howdy","it","i","low","own","part",
	  "partner","sit", "below"]
	matches = {}  
	  
  dictionary.each do |word|
    if string.include?(word)
      if matches.key?(word)
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
