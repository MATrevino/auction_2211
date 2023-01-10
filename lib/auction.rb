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

  #did not finish method/worked on the commented out section. the correct method came after time was over.

  def bidder_info
    hash = Hash.new({})
    hash_of_item_by_attendees = {}

    #other option
    # bidders.to_h do |bidder|
    #   [bidder, 
    #     {
    #     budget: bidder.budget,
    #     items: @items.select { |item| item.bids.keys.include?(bidder) }
    #     }
    #   ]
    # end
    
    items.each do |item|
      item.bids.each do |attendee, bid|
        # require 'pry';binding.pry
        if hash.has_key?(attendee)
          hash[attendee][:items] << item
        else 
          hash[attendee] = { :budget => attendee.budget, :items => [item]}
        end
        # if bid[0].name == bid[0].name
        #   items_for_attendee = []
        #   items_for_attendee.push(item)
        # end
        # hash_of_item_by_attendees[bid] = items_for_attendee
      end
    end
    
    # bidders.each do |bidder|
    #   hash_of_item_by_attendees.map do |attendee|
    #     if bidder.name == attendee[0].name
    #       values_of_items = []
    #       items_only = attendee.pop
    #       values_of_items.push(items_only)
    #       hash[bidder] = {:budget => bidder.budget, :items => values_of_items}
    #     end
    #   end
    # end
    hash
  end

  # def items_group_by_bidder
  #   items_by_bidder = {}
  #   items.map do |item|
  #     items_by_bidder[item] = item.bids
  #   end
  # end
end