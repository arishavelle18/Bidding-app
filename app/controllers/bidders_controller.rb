class BiddersController < ApplicationController
  # check if the user is logged_in
  before_action :require_login
  # before_action :require_admin

  def new
    # product_id
    @product = Product.find_by(id:params[:id])
    # check if empty,have id or not
    if @product
      @bid = Bid.new
      
    else
      flash[:danger] = "Product is not available !!!"
      redirect_to products_path
    end
  end

  # storing in model but we need to check if the bid is qualify or not
  def create
    #product
     @product = Product.find_by(id:params[:bid][:product_id])
     @bid = Bid.new(bid_params)
      # check if has product not closed and it is not expired
     if @product && !@product.stop_switch && (DateTime.now < @product.bidding_expiration )
      # check id if bid is okay
      # check if has no bid  or it has already bid 
      summation = @product.bids.empty? ? (@product.starting_bid_price + @product.lowest_allowable_bid) : (@product.bids.sum(:bid_value) + @product.lowest_allowable_bid)
      
        if @bid.bid_value >= (summation)
          # save the your bid
          @bid.save
          flash[:success]="Bid created successfully !!!"
          redirect_to products_path
      else
        flash[:danger]="Bid value should be greater than or equal to ₱#{summation} !!!"
        render :new
      end
    else
      flash[:danger] = "Product is not available !!!"
      redirect_to products_path
    end
  end

  # create strong parameter
  private def bid_params
    params.require(:bid).permit(:bid_value,:user_id,:product_id)
  end

end
