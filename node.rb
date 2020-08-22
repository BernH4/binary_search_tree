class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    left = nil
    right = nil
  end

  def <=>(other)
    value = other.class == Node ? other.data : other
    self.data <=> value
  end
  
  def to_s
    "Node: #{@data}"
  end
end
