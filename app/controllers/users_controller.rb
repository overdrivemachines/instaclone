class UsersController < ApplicationController
  before_action :set_user

  # @route GET /:username (user)
  def show
    @posts = @user.posts.all
  end

  # @route GET /:username/followers (user_followers)
  # @route GET /:username/followees (user_followees)
  def follow
    # @follow is either followers or followees
    @follow = request.path.split("/").last
    @follow_users = @user.send(@follow)
  end

  # @route GET /:username/saved (user_saved)
  def saved
    flash[:notice] = "Coming Soon"
    flash[:message] = "This feature is unavailable at the moment."
    redirect_to home_message_path
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
