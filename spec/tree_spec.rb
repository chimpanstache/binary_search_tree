require 'node'
require 'tree'

RSpec.describe Tree do
  # describe '#building_tree' do
    
  #   context 'testing a tree' do
  #     tree = Tree.new([6, 4, 7])
  #     tree_root = tree.build_tree

  #     it 'creates a balanced binary sorted tree' do
  #       expect(tree_root.left.data).to eq 4 
  #       expect(tree_root.left.left).to eq nil 
  #       expect(tree_root.left.right).to eq nil 
  #       expect(tree_root.data).to eq 6 
  #       expect(tree_root.right.data).to eq 7 
  #       expect(tree_root.right.left).to eq nil 
  #       expect(tree_root.right.right).to eq nil 
  #     end
  #   end
  # end
  
  describe 'blabla' do
    context 'testing a tree' do
      tree2 = Tree.new([6, 4, 7, 5])
      tree_root_2 = tree2.build_tree

      it 'creates a balanced binary sorted tree' do
        byebug
        expect(tree_root_2.left.data).to eq 4 
        expect(tree_root_2.left.left).to eq nil 
        expect(tree_root_2.left.right).to eq nil 
        expect(tree_root_2.data).to eq 5 
        expect(tree_root_2.right.data).to eq 6 
        expect(tree_root_2.right.left).to eq nil 
        expect(tree_root_2.right.right.data).to eq 7 
      end
    end
  end
end
