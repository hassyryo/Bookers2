class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
     @users = User.all
     @user = User.new
     @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
    redirect_to "/users/#{current_user.id}"
    end
  end

  def update
    @user = User.find(params[:id])
    unless @user.id == current_user.id
    redirect_to "/users/#{current_user.id}"
    end
    
    if @user.update(user_params)
      redirect_to user_path(@user.id) 
      flash[:notice] = 'You have updated user successfully.'
    else 
      render :edit  
    end
  end
 
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
 end
