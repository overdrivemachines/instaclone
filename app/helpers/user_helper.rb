module UserHelper
  # used by users/follow.html.erb
  def caption_for(follow)
    follow == "followers" ? "followers" : "following"
  end

  # used by users/follow.html.erb
  def message_zero_follows(follow)
    follow == "followers" ? "No followers yet." : "Not following anyone."
  end
end
