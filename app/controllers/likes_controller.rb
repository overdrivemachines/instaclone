class LikesController < ApplicationController
  before_action :authenticate_user!
  # @route POST /likes (likes)
  def create
    (redirect_to new_sessions_path && return) unless user_signed_in?

    @like = current_user.likes.new(like_params)
    @like.save
    render partial: "button", locals: { likeable: @like.likeable }
    # render turbo_stream: turbo_stream.replace()

    # respond_to do |format|
    #   format.turbo_stream do
    #     render turbo_stream: [
    #       turbo_stream.replace("like_post_#{@like.likeable_id}", partial: "button",
    #                                                              locals: { likeable: @like.likeable }),
    #       turbo_stream.replace("likes_count_post_#{@like.likeable_id}", @like.likeable.likes.size.to_s + " like(s)")
    #     ]
    #   end
    # end
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
