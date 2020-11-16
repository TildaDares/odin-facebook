class FriendshipsController < ApplicationController
  def create
    flash_message = friendship_message(params[:friend_id])
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    flash_message if @friendship.save
    redirect_to '/friend_requests'
  end

  def destroy
    @friend = User.find(params[:id])
    @friendship = current_user.friendships.find_by_friend_id(params[:id])
    @friendship_two = @friend.friendships.find_by_friend_id(current_user.id)
    @friendship&.destroy
    @friendship_two&.destroy
    unfriendship_message(@friendship, @friendship_two)
    redirect_to root_path
  end

  private

  def unfriendship_message(friendship, friendship_two)
    flash[:notice] = if friendship && friendship_two
                       'User successfully unfriended'
                     elsif friendship_two
                       'Request successfully rejected'
                     else
                       'Friend Request cancelled'
                    end
  end

  def friendship_message(friend_id)
    user = User.find(friend_id)
    if current_user.friend_requests.include?(user)
      send_notification(user)
      flash[:notice] = 'Friend Request successfully accepted'
    else
      flash[:notice] = 'Friend Request successfully sent'
    end
  end

  def send_notification(user)
    @notif = user.notifications.build(message: 'accepted your request', url: url_for(current_user), sender_id: current_user.id)
    @notif.save
  end
end
