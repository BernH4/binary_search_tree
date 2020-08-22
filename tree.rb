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
    # knowing what direction i went before fills my code very hard but i dont know how to work without it yet
    went_left = node_before > node
    if data == node.data
      # Node has 2 childs
      if !node.left.nil? && !node.right.nil?
        #find a replacement and delete it from the bottom
        replacement = delete(find_replacement(node))
        if node == @root
          @root = replacement
        else
          went_left ? node_before.left = replacement : node_before.right = replacement
        end
        replacement.left, replacement.right = node.left, node.right
      # node has 1 child
      elsif node.left.nil? ^ node.right.nil?
        went_left ? node_before.left = node.left || node.right : node_before.right = node.left || node.right
      # node has no child
      else
        went_left ? node_before.left = nil : node_before.right = nil
        node
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
    node.data
  end

  def find(data, node = @root)
    return "#{data} is not part of the tree yet!" if node.nil?
    return node if node == data
    node < data ? find(data, node.right) : find(data, node.left)
  end

  def height(node, curr_height = -1, max_height = 0)
    curr_height += 1
    max_height = curr_height if curr_height > max_height
    max_height = height(node.left, curr_height, max_height) unless node.left.nil?
    max_height = height(node.right, curr_height, max_height) unless node.right.nil?
    max_height
  end

  def depth(node, curr_node = @root, depth = 0)
    return depth if curr_node == node
    depth += 1
    depth = node < curr_node ? depth(node, curr_node.left, depth) : depth(node, curr_node.right, depth)
  end

  def balanced?
    (height(@root.left) - height(@root.right)).between?(-1,1)
  end

  def rebalance
    @root = build_tree(inorder)
  end

  def level_order_iteration
    queue = [@root]
    arr_level_trav = []
    until queue.empty?
      node = queue.shift
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
      arr_level_trav << node.data
    end
    arr_level_trav
  end

  def preorder(node = @root, arr = [])
    arr << node.data
    arr.push(*preorder(node.left)) unless node.left.nil?
    arr.push(*preorder(node.right)) unless node.right.nil?
    arr
  end

  def inorder(node = @root, arr = [])
    arr.push(*inorder(node.left)) unless node.left.nil?
    arr << node.data
    arr.push(*inorder(node.right)) unless node.right.nil?
    arr
  end

  def postorder(node = @root, arr = [])
    arr.push(*postorder(node.left)) unless node.left.nil?
    arr.push(*postorder(node.right)) unless node.right.nil?
    arr << node.data
    arr
  end

  def pretty_print(node = @root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
  end
end

#data = [1, 3, 4, 5, 11, 13, 15, 23, 67, 324, 6345]
# data = [1,2,3,4,5,6,7,8,9]
# data = [1,2,3]
#data = %w(A B C D E F G H I J K)
#p data.uniq.sort
  # myTree = Tree.new(data)
# myTree.pretty_print
# myTree.insert(2)
# puts "------------"
  # myTree.pretty_print
#myTree.delete(50)
#myTree.delete(70)
#puts '----------'
#myTree.pretty_print
#puts myTree.find("B")
  # p myTree.level_order_iteration
#p myTree.preorder
#p myTree.inorder
#p myTree.postorder
#p myTree.height(myTree.find("F"))
#p myTree.depth(myTree.find("A"))
  # p myTree.balanced?
  # myTree.rebalance
  # p myTree.balanced?

