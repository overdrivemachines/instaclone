class HomeController < ApplicationController
  # @route GET / (root)
  def index
    # displaying just 10 posts
    # TODO: load on scroll or paginate
    @posts = user_signed_in? ? current_user.feed.limit(10) : Post.includes(:user).limit(10)

    # TODO: @users_to_follow = current_user.follow_suggessions
    @users_to_follow = current_user.follow_suggestions
  end

  # @route GET /home/message (home_message)
  def message
    # if there is no message redirect to root
    redirect_to root_url unless flash[:notice]
  end
end
