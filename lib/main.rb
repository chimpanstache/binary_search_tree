require_relative 'tree'

# tree = Tree.new(Array.new(rand(1..25)) { rand(-1000..1000) })
# tree = Tree.new([-805, 364, -822, -402, -707, -814, -841, 648])
# puts tree.find(6418)
# tree.preorder { |n| puts "I got #{n.data} problems, but a bitch aint one"}

tree = Tree.new(Array.new(rand(15)) { rand(1..100) })
puts tree.balanced?
tree.pretty_print
ar = Array.new(rand(1..10)) { rand(101..200) }.uniq
while !ar.empty?
  tree.insert(ar.first)
  ar.shift
end
tree.pretty_print
puts tree.balanced?
tree.rebalance
puts tree.balanced?
tree.pretty_print
