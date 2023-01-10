class HomeController < ApplicationController
  # @route GET / (root)
  def index
    # displaying just 10 posts
    # TODO: load on scroll or paginate
    @posts = Post.includes(:user).limit(10)
  end

  # @route GET /home/message (home_message)
  def message
    # if there is no message redirect to root
    redirect_to root_url unless flash[:notice]
  end
end
