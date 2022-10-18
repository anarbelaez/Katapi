module ApplicationHelper
  # TODO
  def avatar
    if user_signed_in? && current_user.photo.attached?
      cl_image_tag(current_user.photo.key, crop: :thumb, gravity: :face)
    else
      image_tag 'https://cdn.pixabay.com/photo/2019/04/06/18/53/ladybug-4108031_960_720.jpg'
    end
  end
end
