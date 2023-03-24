class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    # add to the data base
    @product = Product.create(product_params)
    
    respond_to do |format| 
      if @product.save
         flash[:success] = "Create auction successfully"
          format.html {redirect_to products_path}
      else
          format.html {render :new, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @product = Product.find_by(id:params[:id])
  end

  def update
    @product = Product.find_by(id:params[:id])
    respond_to do |format|
      if @product.update(product_params)
        flash[:success] = "Edit Auction successfully"
        format.html {redirect_to products_path}
      else
        format.html {render :edit,status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      @product = Product.find_by(id:params[:id])
      @product.destroy
      flash[:success] = "Delete Auction successfully"
      format.html {redirect_to products_path}
    end
  end

  # create a strong params
  private def product_params
    params.require(:product).permit(:admin_id,:product_name,:description,:lowest_allowable_bid,:starting_bid_price,:bidding_expiration)
  end

end
