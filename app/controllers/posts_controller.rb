class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.where('user_id IN (?) OR user_id = ?', current_user.mutual_friends, current_user).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Post successfully created'
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    if @post.destroy
      flash[:notice] = 'Post successully destroyed'
      redirect_to root_path
    end
  end

  def toggle_favorite
    @post = Post.find(params[:id])
    if current_user.favorited?(@post)
      current_user.unfavorite(@post)
    else
      send_like_notification(@post.user, @post)
      current_user.favorite(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def send_like_notification(user, post)
    unless user == current_user
      @notif = user.notifications.build(message: 'liked your post', url: url_for(post), sender_id: current_user.id)
      @notif.save
    end
  end
end
