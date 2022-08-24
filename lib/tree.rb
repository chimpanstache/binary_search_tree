require_relative 'node'
class Tree
  attr_accessor :root

  def initialize(array)
    @array = array
    @root = build_tree
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

  def merge_sort(arr)
    if arr.size < 2
      return arr
    else
      left, right = arr.each_slice((arr.size/2.0).round).to_a
      sort(merge_sort(left), merge_sort(right))
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

  def delete
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([4, 5, 2, 11, -1, 1, -2, -4])
# tree.pretty_print
tree.insert(3)
tree.pretty_print
