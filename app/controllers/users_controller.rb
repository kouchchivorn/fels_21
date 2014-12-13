class UsersController < ApplicationController
  before_action :admin_sign_in, only: [:index, :destroy]
  before_action :user_sign_in, only: [:new, :create]
  before_action :set_user, except[:index, :new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Blog"
      redirect_to @user
    else
      render "new"
    end
  end

  def show

  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = "Profile has been updated."
      redirect_to @user
    else
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find params[:id]
    end
end
