def stock_picker(stocks)
	buy = []
	diff = []
	stocks.each_with_index do |buy_stock, x|
		profit = []
		puts profit
		buy << profit

		stocks.each_with_index do |sell_stock, y|
			profit << sell_stock - buy_stock 
			diff << sell_stock - buy_stock if x < y
		end
	end

	buy.index do |x|
		if x.include?(diff.max)
			puts "[#{buy.index(x)},#{x.index(diff.max)}]"
		end
	end
	# puts "[#{buy.index(buy.max)}, #{buy[buy.index(buy.max)][buy.index(buy.max)]}]"
end

stock_picker([17,3,6,9,15,8,6,1,10])