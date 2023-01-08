require './lib/auction'

RSpec.describe Auction do
  let(:auction) {Auction.new}
  
  describe '#initialize' do
    it 'exists' do
      expect(auction).to be_an_instance_of(Auction)
    end
    
    it 'starts with no items' do
      expect(auction.items).to eq([])
    end
  end
end