class SearchesController < ApplicationController
  def index
    @searches = Search.select('*').order(created_at: :desc).limit(5)
  end

  def search
    search = Search.create(words: params[:search])
    @users = User.where('username ILIKE ?', "%#{params[:search]}%")
    @posts = Post.joins(:action_text_rich_text).where('action_text_rich_texts.body ILIKE ?', "%#{params[:search]}%")
    render 'index'
  end

  def destroy
    search = Search.find(params[:id])
    if search.destroy
      flash[:notice] = 'Search successfully destroyed'
      redirect_to searches_path
    else
      render 'index'
    end
  end
end
