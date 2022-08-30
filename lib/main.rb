require_relative 'tree'

tree = Tree.new([50, 30, 20, 40, 32, 34, 36, 70, 60, 65, 80, 75, 85])
# tree.pretty_print
# puts tree.level_order
tree.preorder { |n| puts "I got #{n.data} problems, but a bitch aint one"}
