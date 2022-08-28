require 'node'
require 'tree'

RSpec.describe Tree do
  describe 'blabla' do
    array = Array.new(rand(1..1000)) { rand(-1000..1000) }
    tree = Tree.new(array)
    
    context 'testing a tree' do
      it 'creates a balanced binary sorted tree' do
        expect(ordered_tree?(tree.root)).to be true
        expect(no_duplicates?(tree.root)).to be true
      end
    end

    context '#insert' do
      it 'inserts greatly new nodes' do
        random_number = rand(-1000..1000)
        tree.insert(random_number)
        expect(ordered_tree?(tree.root)).to be true
        expect(no_duplicates?(tree.root)).to be true
      end
    end

    context '#delete' do
      it 'deletes greatly new nodes' do
        random_number = rand(-1000..1000)
        tree.delete(random_number)
        expect(ordered_tree?(tree.root)).to be true
        expect(no_duplicates?(tree.root)).to be true
      end
    end

    context '#find' do
      it 'finds nodes' do
        value = array.sample
        expect(tree.find(value).data).to eq value
      end
    end
  end

  def ordered_tree?(node)
    if node.left
      return false if node.left.data > node.data
      ordered_tree?(node.left)
    end
    if node.right
      return false if node.data > node.right.data
      ordered_tree?(node.right)
    end
    true
  end

  def array_filling(node, ar = [])
    ar << node.data
    if node.left
      array_filling(node.left, ar)
    end
    if node.right
      array_filling(node.right, ar)
    end
    ar    
  end

  def no_duplicates?(root)
    ar = array_filling(root)
    ar == ar.uniq
  end
end
