class Node
  attr_accessor :data, :left, :right
  include Comparable
  def <=>(other)
    data <=> other.data
  end

  def initialize(data = nil)
    @data = data
    left = nil
    right = nil
  end
end
