# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  caption    :text
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
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

  has_one_attached :image

  # resize image so that the width or the height are at least 293 pixels
  # does not resize images smaller than 293 pixels
  def image_as_medium_thumbnail
    if image_width > image_height
      image.variant(resize_to_limit: [nil, 293]).processed
    else
      image.variant(resize_to_limit: [293, nil]).processed
    end
  end

  # get image's width
  def image_width
    image.metadata[:width]
  end

  # get image's height
  def image_height
    image.metadata[:height]
  end
end
