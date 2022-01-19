class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Profile successfully updated'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  # searches for a friend
  def friends_search
    @user = User.find(params[:user_id])
    @search_friends = @user.friends.where('username ILIKE ?', "%#{params[:search]}%")
    render 'friends'
  end

  def friends
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:bio, :location, :header, :avatar, :birthday)
  end
end
