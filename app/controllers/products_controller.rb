class ProductsController < ApplicationController
  # check if the user is logged_in
  before_action :require_login

  def index
    @products = Product.all.order(created_at: :desc)
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
  # show the product and 
  def show
    @product = Product.find_by(id: params[:id])
    if @product
      @bids = @product.bids.order(created_at: :desc)
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
        # if you edit then it will open auction
        @product.update(stop_switch:!@product.stop_switch)
        flash[:success] = "Edit Auction successfully"
        format.html {redirect_to products_path}
      else
        format.html {render :edit,status: :unprocessable_entity}
      end
    end
  end

  def destroy
     # check if you are admin
    if current_user.is_admin
      @product = Product.find_by(id:params[:id])
      if @product
        @product.destroy
        flash[:success] = "Delete Auction successfully"
        redirect_to products_path
      end
    else
      flash[:danger] = "Unauthorized Access !!!"
      redirect_to products_path
    end
  end
# if will stop the bid
  def stopbid
    @product = Product.find_by(id:params[:id])
    @user = User.find_by(id:current_user.id)
   
    if @product && @user.is_admin
      @product.update(stop_switch:!@product.stop_switch)
      redirect_to products_path
    else
      flash[:danger] = "Unauthorized Access !!!"
      redirect_to products_path
    end
  end

  # create a strong params
  private def product_params
    params.require(:product).permit(:user_id,:product_name,:description,:lowest_allowable_bid,:starting_bid_price,:bidding_expiration)
  end
  
  private def is_admin
    check = User.find_by(id:current_user.id,is_admin:true)
    if !check
      flash[:danger] = "Unauthorized Access !!!"
      redirect_to products_path
    end
  end
 


end
