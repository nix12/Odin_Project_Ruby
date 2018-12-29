class LinkedList
	class Node
		attr_accessor :value, :next_node

		def initialize(value = nil, next_node = nil)
			@value = value
			@next_node = next_node
		end
	end

	attr_accessor :head

	def initialize(value)
		@head = Node.new(value)
	end

	def append(value)
		last = @head
		last = last.next_node until head.next_node.nil?
		last.next_node = Node.new(value)
	end

	def prepend(value)
		@head = Node.new(value, @head)
	end

	def size
		current = @head
		count = 0

		while !current.nil?
			current = current.next_node
			count += 1
		end

		count
	end

	def head
		@head
	end

	def tail
		current = @head

		while !current.next_node.nil?
			current = current.next_node
		end

		current
	end

	def at(index)
		current = @head

		if index == 0
			return @head
		else	
			index.times do
				current = current.next_node
			end
		end

		current
	end

	def pop
		current = @head

		while !current.nil?
			current = current.next_node
			current = nil
		end

		current
	end

	def contains?(value)
		return true if @head.value == value
		current = @head

		while !current.next_node.nil?		
			if current.value == value
				return true
				break
			else 
				return false					
			end
		end
	end

	def find(value)
		return 0 if @head.value == value
		current = @head
		index = 0

		until current.value == value
			current = current.next_node
			index += 1
		end

		index
	end

	def to_s
		array = ""
		current = @head
		while !current.nil? 
			array += "( #{ current.value } ) -> "
			current = current.next_node
		end

		array += 'nil'
	end

	def insert_at(index, value)
		current = @head
		counter = 0
		if index == 0
			self.prepend(value) 
		else
			while counter < index
				current = current.next_node
				counter += 1
			end
			new_node = current
			new_node.next_node = Node.new(value, new_node.next_node)
		end
	end

	def remove_at(index)
		current = @head
		
		if index == 0
			@head = @head.next_node
		else
			rm_node = at(index)
			return nil if rm_node.nil?
			rm_node.next_node = rm_node.next_node.next_node
		end
		self
	end
end

list = LinkedList.new('cake')
list.append('turtle')
list.prepend('batman')
# p list.size
# p list.head
# p list.tail
# puts
# p list.at(2)
# p list.pop
# p list.contains?('batman')
# p list.contains?('apple')
# p list.find('turtle')
# p list.insert_at(1, 'spice')
p list.remove_at(1)
p list.to_s