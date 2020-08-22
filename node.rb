class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    left = nil
    right = nil
  end

  def <=>(other)
    # Makes a node also comparable against an Integer
    value = other.class == Node ? other.data : other
    data <=> value
  end

  def to_s
    "Node: #{@data}"
  end
end
