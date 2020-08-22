require 'pry'
require_relative 'tree.rb'

puts '1. Create a binary search tree from an array of random numbers'
tree = Tree.new(Array.new(15) { rand(1..100) })
puts '2. Confirm that the tree is balanced by calling `#balanced?`'
p tree.balanced?
puts '3. Print out all elements in level, pre, post, and in order'
puts "Levelorder:"
p tree.level_order_iteration
puts "Preorder:"
p tree.preorder
puts "Inorder:"
p tree.inorder
puts "Postorder:"
p tree.postorder
puts '4. try to unbalance the tree by adding several numbers > 100'
10.times { tree.insert(rand(101..200)) }
tree.pretty_print
puts '5. Confirm that the tree is unbalanced by calling `#balanced?`'
p tree.balanced?
puts '6. Balance the tree by calling `#rebalance`'
tree.rebalance
tree.pretty_print
puts '7. Confirm that the tree is balanced by calling `#balanced?`'
p tree.balanced?
puts '8. Print out all elements in level, pre, post, and in order'
puts "Levelorder:"
p tree.level_order_iteration
puts "Preorder:"
p tree.preorder
puts "Inorder:"
p tree.inorder
puts "Postorder:"
p tree.postorder
