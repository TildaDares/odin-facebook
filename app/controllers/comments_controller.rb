class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment: params[:comment], post: @post)
    if @comment.save
      send_notification('commented on your post', @post.user, url_for([@post, @comment]))
      redirect_to post_path(@post)
    else
      flash[:alert] = 'One photo per comment and comments cannot be empty'
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    if @comment.destroy
      flash[:notice] = 'Comment successfully destroyed'
      redirect_to post_path(@post)
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def toggle_favorite
    @comment = Comment.find(params[:id])
    if current_user.favorited?(@comment)
      current_user.unfavorite(@comment)
    else
      send_notification('liked your comment', @comment.user, url_for([@comment.post, @comment]))
      current_user.favorite(@comment)
    end
  end
end
