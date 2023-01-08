require './lib/auction'
require './lib/item'

RSpec.describe Auction do
  let(:auction) {Auction.new}
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') }
  describe '#initialize' do
    it 'exists' do
      expect(auction).to be_an_instance_of(Auction)
    end
    
    it 'starts with no items' do
      expect(auction.items).to eq([])
    end

    it 'can add items' do
      auction.add_item(item1)
      auction.add_item(item2)
      expect(auction.items).to eq([item1, item2])
    end

    it 'can return list of item names' do
      auction.add_item(item1)
      auction.add_item(item2)
      expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end
end