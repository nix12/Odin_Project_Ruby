def merge_sort(arr)
	return arr if arr.length == 1
	a = merge_sort(arr[0...arr.length/2])
	b	=	merge_sort(arr[arr.length/2..-1])
	merge(a, b)
end

def merge(arr1, arr2)
	arr1 = arr1.sort
	arr2 = arr2.sort
	merged_array = []
	a = 0
	b = 0

	while a < arr1.length && b < arr2.length
		if arr1[a] < arr2[b]
			merged_array << arr1[a]
			a += 1
			# puts "> #{ a }"
		else
			merged_array << arr2[b]
			b += 1
			# puts "- #{ b }"
		end
	end
	merged_array += arr1[a..-1] 
	merged_array += arr2[b..-1]
	return merged_array
end

p merge_sort(merge([80, 46, 9, 23, 22, 45, 33, 2], [21, 43, 87, 98, 32, 55, 7, 4]))
