class Product < ApplicationRecord
  belongs_to :admin_user
  has_many :bids, dependent: :delete_all
  # check if the post is created by the admin
  # attr_accessor:create_by_admin
  # before_save:set_created_by_admin_flag
  # def set_created_by_admin_flag
  #   self.create_by_admin = user&.is_admin?
  # end


  # check if the bidder is uniq and cannot be repeated
  def bids_sum
    bids.sum(:bid_value)
  end
  
  def winner
    (bidding_expiration <= DateTime.now || (stop_switch && bids.nil?)) ? "₱#{bids_sum}" : "None"
  end
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
