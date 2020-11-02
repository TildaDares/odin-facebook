class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
    @users = User.all.sample(3)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    if @post.destroy
      flash[:notice] = "Post successully destroyed"
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
