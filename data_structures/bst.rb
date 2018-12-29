class BinaryTree
	class Node
		attr_reader :value
		attr_accessor :left, :right

		def initialize value, left = nil, right = nil
			@value = value
			@left = left
			@right = right
		end
	end

	def initialize
		@root = nil
	end

	def add_node node, root
		if node.value < root.value
			if root.left.nil?
				root.left = node
			else
				add_node(node, root.left)
			end
			# p root.left
		else
			if root.right.nil?
				root.right = node
			else
				add_node(node, root.right)
			end
			# p root.right
		end
		# p root
		# puts '..............................'
	end

	def build_tree array
		# array = array.sort
		@root = Node.new array[0]
		array.each_with_index do |value, index|
			add_node Node.new(value), @root if index > 0
		end
	end

	def breadth_first_search value
		queue = [@root]

		queue.each do |node|
			return node if node.value == value
			queue << node.left if node.left
			queue << node.right if node.right
			# p node.value
		end
	end 

	def depth_first_search value
		stack = [@root]
		
		loop do
			break if stack.empty?
			node = stack.pop
			return node if node.value == value

			stack << node.left if node.left
			stack << node.right if node.right
		end
		# p stack
	end

	def dfs_rec value, node = @root		
		p node if node.value == value
		dfs_rec(value, node.left) if node.left
		dfs_rec(value, node.right) if node.right
	end
end

tree = BinaryTree.new
# node = Node.new
tree.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# p tree.breadth_first_search(9)
# p tree.depth_first_search(67)
p tree.dfs_rec(3)