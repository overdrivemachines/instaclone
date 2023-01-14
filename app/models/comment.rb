# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  # Requires comments_count column in posts table.
  # post.comments.size will be quick
  belongs_to :post, counter_cache: true
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  before_validation :set_correct_parent
  validates :body, presence: true, length: { maximum: 2200 }

  def set_correct_parent
    # top level comment, there is no parent
    return if parent_id.blank?

    # Check if parent_id is valid
    throw :abort unless Comment.exists?(parent_id)

    # 2nd level comment, leave the parent as is
    return if parent.parent_id.blank?

    # Check if parent's parent_id is valid
    throw :abort unless Comment.exists?(parent.parent_id)

    # Convert 3rd level to 2nd level comment
    self.parent_id = parent.parent_id

    # TODO: verify that the comment's post id is the same as the parent's post id
  end
end
