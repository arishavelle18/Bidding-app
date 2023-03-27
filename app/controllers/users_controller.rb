class UsersController < ApplicationController
  before_action :not_require_login, except:[:show]
  # navigate to register form
  def new
    @user = User.new
  end

  # create acc and automatically login
  def create
    @user = User.create(user_params)
    respond_to do |format|
      if @user.save
        flash[:success]="Register successfully"
        log_in @user
        format.html {redirect_to products_path}
      else
        format.html {render :new,status: :unprocessable_entity}
      end
    end
  end

  # visit history log
  def show
    @user = User.find_by(id:current_user.id,is_admin:false)
      if @user
        @bids = @user.bids.order(created_at: :desc)
      else
        flash[:warning]="You should be a Bidder !!!"
        redirect_to products_path
      end
  end

  # create strong params
  private 
  def user_params
    params.require(:user).permit(:full_name,:email,:password,:password_confirmation)
  end

end
