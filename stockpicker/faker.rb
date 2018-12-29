def stock_picker(arr)
best_buy = 0
best_sell = 0
max_profit = 0
arr[0..-2].each_with_index do |buy, i|
arr[(i+1)..-1].each_with_index do |sell, j|
if (sell - buy) > max_profit
best_sell = j + (i + 1)
best_buy = i
max_profit = sell - buy
end
end
end
[best_buy, best_sell]
end
puts stock_picker([17,3,6,9,15,8,6,1,10]).inspect 