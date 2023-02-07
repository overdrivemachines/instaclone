class HomeController < ApplicationController
  # @route GET / (root)
  def index
    # displaying just 10 posts
    # TODO: load on scroll or paginate
    if user_signed_in?
      @posts = current_user.feed.limit(10).shuffle
      @users_to_follow = current_user.follow_suggestions
    else
      @posts = User.feed.limit(10).shuffle
      @users_to_follow = User.follow_suggestions
    end
  end

  # @route GET /home/message (home_message)
  def message
    # if there is no message redirect to root
    redirect_to root_url unless flash[:notice]
  end

  # @route GET /home/inbox (home_inbox)
  def inbox
    flash[:notice] = "Coming Soon"
    flash[:message] = "This feature is unavailable at the moment."
    redirect_to home_message_path
  end
end
