require 'pry'
require_relative 'node.rb'

class Tree
  def initialize(data_arr)
    @data_arr = data_arr.uniq.sort
    @root = build_tree(@data_arr)
  end

  def build_tree(arr)
    # TODO: Base case efficient?
    return if arr.empty?

    mid = arr.length / 2
    node = Node.new(arr[mid])
    node.left = build_tree(arr[0, mid])
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

  def delete(data, node = @root, node_before = @root)
    # knowing what direction i went before fills this code but i dont know how to work without it
    went_left = node_before > node
    if data == node.data
      # true if node has only one child
      if node.left.nil? ^ node.right.nil?
        went_left ? node_before.left = node.left || node.right : node_before.right = node.left || node.right
      else went_left ? node_before.left = nil : node_before.right = nil
      end
    elsif data > node.data
      delete(data, node.right, node)
    elsif data < node.data
      delete(data, node.left, node)
    end
  end

  def find_replacement(node)
    # go to the right side of the node and search for the next higher data
    node = node.right
    node = node.left until node.left.nil?
    # TODO maybe remove this return node, probably will work anyway
    node
  end

  def pretty_print(node = @root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
  end
end

# data = [1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345]
# data = [1,2,3,4,5,6,7,8,9]
# data = [1,2,3]
data = [20, 30, 32, 34, 36, 40, 50, 60, 65, 70, 75, 80, 85]
p data.uniq.sort
myTree = Tree.new(data)
# myTree.pretty_print
# myTree.insert(2)
# puts "------------"
myTree.pretty_print
# myTree.delete(40)
myTree.delete(70)
puts '----------'
myTree.pretty_print
