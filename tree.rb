require 'pry'
require_relative 'node.rb'

class Tree
  def initialize(data_arr)
    @data_arr = data_arr.uniq.sort
    @root = build_tree(@data_arr)
  end

  def build_tree(arr)
    #TODO Base case efficient?
    return if arr.length == 0
    mid = arr.length / 2 
    node = Node.new(arr[mid])
    node.left = build_tree(arr[0,mid])
    node.right = build_tree(arr[mid + 1..-1])
    node
  end

  def insert(data, node = @root)
    if !data.is_a?(Integer)
      puts "'#{data}' is not a valid input, only integers!"
    elsif data > node.data
      node.right.nil? ? node.right = Node.new(data) : insert(data, node.right)
    elsif data < node.data
      node.left.nil? ? node.left = Node.new(data) : insert(data, node.left)
    elsif data == node.data
      puts "'#{data}' is already in the tree!"
    end
  end

  def pretty_print(node = @root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
  end
end

#data = [1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345]
#data = [1,2,3,4,5,6,7,8,9]
#data = [1,2,3]
data_w_30 = [20,32,34,36,40,50,60,65,70,75,80,85]
data_wo_30 = [20,30,32,34,36,40,50,60,65,70,75,80,85]
#p data.uniq.sort
myTree_w_30 = Tree.new(data_w_30)
myTree_wo_30 = Tree.new(data_wo_30)

#myTree.pretty_print
#myTree.insert(2)
#puts "------------"

myTree_w_30.pretty_print
puts "------------_"
myTree_wo_30.pretty_print
