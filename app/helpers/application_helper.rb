module ApplicationHelper
  # TODO
  def get_avatar_url
    if user_signed_in? && current_user.photo.attached?
      cl_image_path(current_user.photo.key, crop: :thumb, gravity: :face, width: 400, height: 400)
    elsif resource.provider == 'google_oauth2'
      current_user.avatar_url
    else
      "https://cdn.dribbble.com/userupload/3223956/file/original-a1ec1b680192b47fbed0b399d03cee62.png?compress=1&resize=400x400&vertical=top"
    end
  end
end
