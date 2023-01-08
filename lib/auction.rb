class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    items.push(item)
  end

  def item_names
    items.map do |item|
      item.name
    end
  end

  def unpopular_items
    items.find_all do |item|
      item.bids.empty?
    end
  end

  def potential_revenue
    potential = []
    items.find_all do |item|
      potential << item.current_high_bid
    end
    potential.compact.sum
  end

  def bidders
    all_bidders = []

    items.find_all do |item|
     next if item.bids.empty? == true
      all_bidders << item.bids.keys
    end
    all_bidders.flatten.uniq
  end
end