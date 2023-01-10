class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # @route GET /posts/:post_id/comments (post_comments)
  def index
    @comments = Comment.all
  end

  # @route GET /posts/:post_id/comments/:id (post_comment)
  def show
  end

  # @route GET /posts/:post_id/comments/new (new_post_comment)
  def new
    @comment = Comment.new
  end

  # @route GET /posts/:post_id/comments/:id/edit (edit_post_comment)
  def edit
  end

  # @route POST /posts/:post_id/comments (post_comments)
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment, notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
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

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id, :parent_id)
    end
end
