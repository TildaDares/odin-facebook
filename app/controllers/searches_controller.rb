class SearchesController < ApplicationController
  def index
    @searches = current_user.searches.select('*').order(created_at: :desc).limit(5)
  end

  def search
    search = current_user.searches.build(words: params[:search]).save
    @users = User.where('username ILIKE ?', "%#{params[:search]}%")
    @posts = Post.joins(:action_text_rich_text).where('action_text_rich_texts.body ILIKE ?', "%#{params[:search]}%")
    render 'index'
  end

  def destroy
    search = current_user.searches.find(params[:id])
    if search.destroy
      flash[:notice] = 'Search successfully destroyed'
      redirect_to searches_path
    else
      render 'index'
    end
  end
end
