class ProductsController < ApplicationController
  # check if the user is logged_in
  before_action :require_login


  def index
    @products = Product.all
  end

  def new
    # check if you are admin
    is_admin
    @product = Product.new
  end

  def create
    # check if you are admin
    is_admin
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
     # check if you are admin
     is_admin
    @product = Product.find_by(id:params[:id])
  end

  def update
    # check if you are admin
    is_admin
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
     # check if you are admin
    is_admin
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
  
  private def is_admin
    check = User.find_by(id:current_user.id,is_admin:true)
    if !check
      flash[:danger] = "Unauthorized Access !!!"
      redirect_to products_path
    end

    true
  end
 


end
