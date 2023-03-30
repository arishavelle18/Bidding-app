class ProductsController < ApplicationController
  # check if the user is logged_in
  before_action :require_login

  def index
    @products = Product.where(stop_switch:false).order(created_at: :desc)
  end

  # show the product and 
  def show
    @product = Product.find_by(id: params[:id])
    if @product
      @bids = @product.bids.order(created_at: :desc)
    end
  
  end
 


end
