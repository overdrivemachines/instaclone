class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # @route POST /relationships (relationships)
  def create
    @relationship = Relationship.new(relationship_params)
    @relationship.follower = current_user

    # save the relationship. do not save if user is trying to follow themself
    @relationship.save if @relationship.follower != @relationship.followee
    render partial: "button", locals: { followee: @relationship.followee }
  end

  # @route DELETE /relationships/:id (relationship)
  def destroy
    relationship = Relationship.find(params[:id])
    followee = relationship.followee
    relationship.destroy
    render partial: "button", locals: { followee: followee }
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followee_id)
  end
end
