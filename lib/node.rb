module State
  LEAF = 1
  ONE_CHILD = 2
  TWO_CHILD = 3
end

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

  def state
    if @left.nil? && @right.nil?
      @state = State::LEAF
    elsif @left.nil? || @right.nil? 
      @state = State::ONE_CHILD
    else
      @state = State::TWO_CHILD
    end
  end

  def modify_child(value, new_child)
    if @left&.data == value
      @left = new_child
    elsif @right&.data == value
      @right = new_child
    end

    nil
  end

  def delete_child(value)
    if value == @left&.data
      @left = nil
    elsif value == @right&.data
      @right = nil
    end
  end
end
