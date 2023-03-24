class Product < ApplicationRecord
  belongs_to :admin
  has_many :bids

  # it must be present
  validates :product_name,presence:true,length: { maximum: 500 }
  validates :description,presence:true
  # it must be present and it must greather than and equal zero
  validates :lowest_allowable_bid,presence:true,
      numericality:{greater_than_or_equal_to:0,only_integer:true}
  # it must be present and it must greather than and equal zero
  validates :starting_bid_price,presence:true,
      numericality:{greater_than_or_equal_to:0,only_integer:true}

# it must be present and it must be
  validates :bidding_expiration,presence:true, timeliness: { 
    on_or_after: lambda{DateTime.now}, 
    type: :datetime,between:[DateTime.now,1.year.from_now] }

end
