require_relative 'tree'

tree = Tree.new(Array.new(rand(1..25)) { rand(-1000..1000) })
tree = Tree.new([-805, 364, -822, -402, -707, -814, -841, 648])
# tree = Tree.new([400])
tree.pretty_print
puts tree.depth(tree.find(648))
# tree.preorder { |n| puts "I got #{n.data} problems, but a bitch aint one"}
