class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :admin_user,     only: :destroy
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

   def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

   # Confirms the correct user.
   def correct_user
     @user = User.find(params[:id])
     redirect_to(root_url) unless current_user?(@user)
   end

   # Confirms an admin user.
   def admin_user
     redirect_to(root_url) unless current_user.admin?
   end
end
