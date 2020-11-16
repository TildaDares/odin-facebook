class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment: params[:comment], post: @post)
    if @comment.save
      send_comment_notification(@post.user, @post, @comment)
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
      send_like_notification(@comment.user, @comment.post, @comment)
      current_user.favorite(@comment)
    end
  end

  private

  def send_comment_notification(user, post, comment)
    unless user == current_user
      @notif = user.notifications.build(message: 'commented on your post', url: url_for([post, comment]), sender_id: current_user.id)
      @notif.save
    end
  end

  def send_like_notification(user, post, comment)
    unless user == current_user
      @notif = user.notifications.build(message: 'liked your comment', url: url_for([post, comment]), sender_id: current_user.id)
      @notif.save
    end
  end
end
