class UsersController < ApplicationController
  before_action :set_user

  # @route GET /:username (user)
  def show
    @posts = @user.posts.all
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
