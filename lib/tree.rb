require_relative 'node'
class Tree
  attr_accessor :root, :current, :parent

  def initialize(array)
    @array = array
    @root = build_tree
    set_node_status
  end

  def merge_sort(arr)
    if arr.size < 2
      return arr
    else
      left, right = arr.each_slice((arr.size/2.0).round).to_a
      sort(merge_sort(left), merge_sort(right))
    end
  end

  def set_node_status(node = @root)
    node.define_state
    
    set_node_status(node.left) unless node.left.nil?
    set_node_status(node.right) unless node.right.nil?
  end

  def build_tree
    building_tree(merge_sort(@array.uniq), 0, (@array.uniq.size - 1))
  end

  def insert(value, node = @root)
    return nil if @array.include?(value)

    if value < node.data
      return node.left = Node.new(value) if node.left.nil?
      
      insert(value, node.left)
    else
      return node.right = Node.new(value) if node.right.nil?

      insert(value, node.right)
    end
  end

  def delete(value)
    return nil unless @array.include?(value)
    @parent, @current = search_node_and_parent(value)

    if @current.state == State::LEAF
      first_case(value)
    elsif @current.state == State::ONE_CHILD
      second_case(value)
    else
      third_case
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def building_tree(ar, start, tip)
    return nil if (start > tip)
    mid = (start + tip) / 2
    root = Node.new(ar[mid])
    root.left = building_tree(ar, start, (mid.abs-1))
    root.right = building_tree(ar, (mid+1), tip)
    root
  end

  def first_case(value)
    @parent.delete_child(value)
  end

  def second_case(value)
    if @current.left.nil?
      @parent.modify_child(@current.data, @current.right)
    elsif @current.right.nil?
      @parent.modify_child(@current.data, @current.left) 
    end
  end

  def third_case
    next_biggest = find_next_biggest

    @current.data = next_biggest.data

    next_biggest, next_biggest_parent = search_node_and_parent(next_biggest.data)
 
    next_biggest_parent.left = next_biggest.right
  end
  
  def sort(left, right)
    sorted = []
    while !left.empty? && !right.empty? do
      if left[0] < right[0]
        sorted << left[0]
        left.shift
      else
        sorted << right[0]
        right.shift
      end
    end
    if left.empty?
      sorted.concat(right)
    else
      sorted.concat(left)
    end
    sorted
  end

  def find_next_biggest(node = @current.right)
    find_next_biggest(node.left) if node.left 
    
    node
  end 

  def search_node_and_parent(value, node = @root)
    if value > node.data
      return [node, node.right] if node.right.data == value
      search_node_and_parent(value, node.right)
    else
      return [node, node.left] if node.left.data == value
      search_node_and_parent(value, node.left)
    end
  end
end

tree = Tree.new([4, 5, 2, 11, -1, 1, -2, -4])
# tree.pretty_print
tree.delete(2)
tree.pretty_print
