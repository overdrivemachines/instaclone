class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[ edit update destroy ]
  before_action :set_post

  # @route GET /posts/:post_id/comments/:id/edit (edit_post_comment)
  def edit; end

  # @route POST /posts/:post_id/comments (post_comments)
  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    @new_comment = @post.comments.new

    if !@comment.save
      render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@comment, helpers.dom_id(@post))}_form", partial: "form",
                                                                                                           locals: { post: @post, comment: @comment })
    else
      flash.now[:notice] = "Comment added!"
    end
  end

  # @route PATCH /posts/:post_id/comments/:id (post_comment)
  # @route PUT /posts/:post_id/comments/:id (post_comment)
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # @route DELETE /posts/:post_id/comments/:id (post_comment)
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: "Comment was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id, :parent_id)
  end
end
