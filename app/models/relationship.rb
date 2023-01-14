# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followee_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_relationships_on_followee_id                  (followee_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followee_id  (follower_id,followee_id) UNIQUE
#
class Relationship < ApplicationRecord
  belongs_to :followee, class_name: "User"
  belongs_to :follower, class_name: "User"

  # Follower: the person creating the follow
  # Followee: the person who is gaining that follower

  validates :follower_id, uniqueness: { scope: :followee_id }, presence: true
  validates :followee_id, uniqueness: { scope: :follower_id }, presence: true
end
