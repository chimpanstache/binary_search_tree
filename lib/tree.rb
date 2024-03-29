require_relative 'node'
require 'byebug'
class Tree
  attr_accessor :root, :current, :parent

  def initialize(array)
    @array = array
    @root = build_tree
  end

  def merge_sort(arr)
    if arr.size < 2
      return arr
    else
      left, right = arr.each_slice((arr.size/2.0).round).to_a
      sort(merge_sort(left), merge_sort(right))
    end
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
    @parent, @current = search_parent_and_node(value)

    if @current.state == State::LEAF
      @parent.delete_child(value)
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

  def find(value)
    parent, node = search_parent_and_node(value)
    node
  end

  def level_order(&block)
    return if root.nil?
    return level_order_with_block(&block) if block_given?

    level_order_no_block
  end
  
  def inorder(node = @root, ar = [], &block)
    return if node.nil?
    inorder(node.left, ar, &block)
    if block_given?
      yield node
    else
      ar << node.data
    end
    inorder(node.right, ar, &block)
    return ar unless block_given?
  end

  def preorder(node = @root, ar = [], &block)
    return if node.nil?
    if block_given?
      yield node
    else
      ar << node.data
    end
    preorder(node.left, ar, &block)
    preorder(node.right, ar, &block)
    return ar unless block_given?
    ar
  end
  
  def postorder(node = @root, ar = [], &block)
    return if node.nil?
    postorder(node.left, ar, &block)
    postorder(node.right, ar, &block)
    yield node if block_given?
    return ar << node.data unless block_given?
  end
  
  def height(node)
    return 0 if node.nil?
    @h = []
    height_navigation(node)
    @h.max
  end

  def depth(node)
    return 0 if node.nil?
    @d = []
    depth_navigation(node)
    @d.first
  end  
  
  def balanced?(node = root)
    @b = []
    balanced_navigation
    @b.all?
  end  

  def rebalance
    @array = level_order
    @root = build_tree
  end

  private
  
  def balanced_navigation(node = root)
    return if node.nil?
    difference = height(node.left) - height(node.right)
    difference.abs > 1 ? @b << false : @b << true
    balanced_navigation(node.left)
    balanced_navigation(node.right)
  end

  def depth_navigation(node, start = root, count = 0)
    @d << count if start == node
    count = depth_navigation(node, start.left, count += 1) unless start.left.nil?
    count = depth_navigation(node, start.right, count += 1) unless start.right.nil?
    count -= 1
  end

  def height_navigation(node, count = 0)
    @h << count
    count = height_navigation(node.left, count += 1) unless node.left.nil?
    count = height_navigation(node.right, count += 1) unless node.right.nil?
    count -= 1
  end
  
  def level_order_no_block
    stack = []
    stack_to_return = []
    stack.push(root.data)

    until stack.empty?
      current = stack.first
      stack.push(find(current).left.data) if find(current).left
      stack.push(find(current).right.data) if find(current).right
      stack_to_return << current
      stack.shift
    end
    stack_to_return
  end    
  
  def level_order_with_block(&block)
    stack = []
    stack.push(root)

    until stack.empty?
      current = stack.first
      yield current
      stack.push(current.left) if current.left
      stack.push(current.right) if current.right
      stack.shift
    end
  end

  def building_tree(ar, start, tip)
    return nil if (start > tip)
    mid = (start + tip) / 2
    root = Node.new(ar[mid])
    root.left = building_tree(ar, start, (mid.abs-1))
    root.right = building_tree(ar, (mid+1), tip)
    root
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

    next_biggest_parent, next_biggest = search_parent_and_node(next_biggest.data)

    @current.data = next_biggest.data
    
    if next_biggest.state == State::LEAF
      next_biggest_parent.delete_child(next_biggest.data)
    else
      next_biggest_parent.left = next_biggest.right
    end
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
    return find_next_biggest(node.left) if node.left    
    
    node
  end 

  def search_parent_and_node(value, node = @root)
    return nil if node.nil?
    return [nil, node] if value == node.data

    if value > node.data
      return [node, node.right] if node.right&.data == value
      search_parent_and_node(value, node.right)
    else
      return [node, node.left] if node.left&.data == value
      search_parent_and_node(value, node.left)
    end
  end
end


