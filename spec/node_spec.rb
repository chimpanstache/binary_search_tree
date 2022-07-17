require 'node'

RSpec.describe Node do
  describe '<=>' do
    one = Node.new(1)
    two = Node.new(2)
    three = Node.new(3)
    
    it 'enables comparison between node data' do
      expect(one < two).to be_truthy
      expect(one < three).to be_truthy
      expect(one <= three).to be_truthy
      expect(one == one).to be_truthy
      expect(one == two).to be_falsy
      expect(two.between?(one, three)).to be_truthy
      expect([two, one, three].sort).to eq [one, two, three]
    end
  end
end
