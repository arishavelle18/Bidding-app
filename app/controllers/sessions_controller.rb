class SessionsController < ApplicationController
  # check restriction
  before_action :require_login, only:[:destroy]
  before_action :not_require_login, only:[:new,:create]
  def new
    @user = User.new
  end

  # login
  def create
    @user = User.find_by(email:params[:user][:email])
    respond_to do |format|
      if @user && @user.authenticate(params[:user][:password])
        flash[:success] ="Login Successfully"
        log_in @user
        format.html {redirect_to products_path}
      else
        flash.now[:danger]="Invalid email or password!"
        format.html {render :new, status: :unprocessable_entity}
      end
    end
  end

  # logout
  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

end
