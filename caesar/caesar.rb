def caesar_cipher(string, number)
	alpha = ("a".."z" + " ").to_a
	text = string.downcase.split("")
	key = number.to_i

	text.each do |x|
		val = alpha.index(x)
	
		if val + key >= alpha.length
			print alpha[(val + key) - alpha.length]
		else
			print alpha[val + key]
		end
	end	 
end

caesar_cipher("What a string!", 5)
