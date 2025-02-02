require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Auction do
  let(:auction) {Auction.new}
  let(:item1) { Item.new('Chalkware Piggy Bank') }
  let(:item2) { Item.new('Bamboo Picture Frame') }
  let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
  let(:item4) { Item.new('2 Days Dogsitting') }
  let(:item5) { Item.new('Forever Stamps') }
  let(:attendee1) { Attendee.new(name: 'Megan', budget: '$50') }
  let(:attendee2) { Attendee.new(name: 'Bob', budget: '$75') }
  let(:attendee3) { Attendee.new(name: 'Mike', budget: '$100') }

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

  describe 'iteration#2' do
    it 'can return a hash of bids' do
      auction.add_item(item1)

      expect(item1.bids).to eq({})
    end

    it 'can add bids and return hash of bids per item' do
      auction.add_item(item1)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.bids).to eq({attendee2 => 20, attendee1 => 22})
    end

    it 'can return current highest bid for an item' do
      auction.add_item(item1)

      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)

      expect(item1.current_high_bid).to eq(22)
    end

    it 'can return list of items without bids/unpopular' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq([item2, item3, item5])

      item3.add_bid(attendee2, 15)
      expect(auction.unpopular_items).to eq([item2, item5])
    end

    it 'calculate and return potential revenue' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expect(auction.potential_revenue).to eq(87)
    end
  end

  describe 'iteration#3' do
    it 'can return an array of attendees who placed a bid' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item3.add_bid(attendee2, 15)
      
      expect(auction.bidders).to eq([attendee2, attendee1])
      item4.add_bid(attendee3, 50)
      expect(auction.bidders).to eq([attendee2, attendee1, attendee3])
    end

    #not a working method
    it 'can return a hash of bidder info' do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)

      expected_hash = {
        attendee2 => 
        {
          :budget => 75,
          :items => [item1, item3]
        },
        attendee1 => 
        {
          :budget => 50,
          :items => [item1]
        },
        attendee3 => 
        {
          :budget => 100,
          :items => [item4]
        }
        }

      expect(auction.bidder_info).to eq(expected_hash)
    end
  end
   
end