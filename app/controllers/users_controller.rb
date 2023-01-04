class UsersController < ApplicationController
  before_action :set_user

  # GET /:username
  def show
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
