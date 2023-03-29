class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :bid_value,presence:true,numericality:{greater_than_or_equal_to:0,only_integer:true}

  validate :bid_value_greater_than_product_bids_total

  # Checking if the bid is present and product_id then check the bidvalue is greater than the summation of bid_value

  def bid_value_greater_than_product_bids_total
    if product_id.present? && bid_value.present?
      if bid_value < (product.bids.sum(:bid_value) +product.lowest_allowable_bid)
        errors.add(:bid_value, "must be greater than or equal the total of all bids for the selected product  ₱#{product.bids.sum(:bid_value)+product.lowest_allowable_bid}")
      elsif product.stop_switch
        # check if the product switch is already stop
        errors.add(:bid_value, "The Auction is already Closed")
      end
      

    end
  end
end
