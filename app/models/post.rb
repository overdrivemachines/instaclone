# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  location       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  has_one_attached :image

  # resize image so that the width or the height are at least 293 pixels
  # does not resize images smaller than 293 pixels
  # https://github.com/janko/image_processing/blob/master/doc/vips.md
  def image_as_medium_thumbnail
    image.variant(resize_to_fill: [293, 293]).processed
  end
end
