module ApplicationHelper
  def friendship_status(user)
    if current_user.friend_requests.include?(user)
      'Accept Request'
    elsif current_user.mutual_friends.include?(user)
      'Unfriend'
    elsif current_user.sent_requests.include?(user)
      'Cancel Request'
    else
      'Add Friend'
    end
  end

  def time_difference(time)
    distance_of_time_in_words(Time.now, time, scope: 'datetime.distance_in_words.short', include_seconds: true)
  end
end
