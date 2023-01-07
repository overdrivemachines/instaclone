class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

  # @route GET /posts/:id (post)
  def show; end

  # @route GET /posts/new (new_post)
  def new
    @post = current_user.posts.build
  end

  # @route GET /posts/:id/edit (edit_post)
  def edit; end

  # @route POST /posts (posts)
  def create
    if params[:post][:image].blank?
      flash.now[:alert] = "You must attach an image"

      render :new, status: :unprocessable_entity

    end

    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to current_user, notice: "Shared new post"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @route PATCH /posts/:id (post)
  # @route PUT /posts/:id (post)
  def update
    if @post.update(post_params)
      redirect_to current_user, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # @route DELETE /posts/:id (post)
  def destroy
    @post.destroy
    redirect_to current_user, notice: "Post was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption, :location, :image)
  end
end
