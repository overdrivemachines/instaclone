class LikesController < ApplicationController
  before_action :authenticate_user!
  # @route POST /likes (likes)
  def create
    @like = current_user.likes.new(like_params)
    @like.save
    render partial: "button", locals: { likeable: @like.likeable }
    # render turbo_stream: turbo_stream.replace()
  end

  # @route DELETE /likes/:id (like)
  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    render partial: "button", locals: { likeable: @like.likeable }
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
