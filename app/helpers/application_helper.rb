module ApplicationHelper
  # returns an image tag for user avatar image (thumbnail)
  def user_avatar_image(user:, class_name: nil)
    if user.avatar.attached?
      image_tag user.avatar_as_thumbnail, class: class_name
    else
      image_tag "person-placeholder.jpg", class: class_name
    end
  end

  # returns an image tag for user avatar background image (thumbnail)
  def user_avatar_background_image(user:, class_name: nil)
    if user.avatar_background.attached?
      image_tag current_user.avatar_background_as_thumbnail, class: class_name
    else
      image_tag "bg-placeholder", class: class_name
    end
  end
end
