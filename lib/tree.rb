require 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @array = array
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

  def build_tree(ar)
    sorted_ar = merge_sort(ar.uniq)
  end
end
