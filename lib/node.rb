class Node
  include Comparable
  attr_accessor :left, :right, :data

  def initialize(data = nil)
    @data = data
    @right = @left = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
