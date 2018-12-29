def fib(n)
	a = b
	b = a
	c = a + b
	arr = [a, b]
	arr.each do
		arr << c
		puts c
	end
	puts arr
end

fib(5)