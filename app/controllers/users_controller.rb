class UsersController < ApplicationController
  before_action :user_authenticate!, except: [:home, :new, :create]
  
  def home
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_login_path(@users)
    else
      flash[:info] = "Something went wrong during user creation. Try again."
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:info] = "Update successful! Logging you out."
      session[:user_id] = nil
      redirect_to "/"
    else
      flash[:info] = "Something went wrong. Try again."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:info] = "We're sorry to lose you as a customer."
    redirect_to "/"
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :name, :address, :password)
  end
end