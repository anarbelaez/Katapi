module ApplicationHelper
  # TODO

  include Pagy::Frontend

  def get_avatar_url
    if user_signed_in? && current_user.photo.attached?
      cl_image_path(current_user.photo.key, crop: :thumb, gravity: :face, width: 400, height: 400)
    elsif resource.provider == 'google_oauth2'
      current_user.avatar_url
    else
      "https://cdn.dribbble.com/userupload/3223956/file/original-a1ec1b680192b47fbed0b399d03cee62.png?compress=1&resize=400x400&vertical=top"
    end
  end

  def sort_link_to(name, column, **options)
    if params[:sort] == column.to_s
      direction = params[:direction] == "asc" ? "desc" : "asc"
    else
      direction = "asc"
    end
    link_to name, request.params.merge(sort: column, direction: direction), **options
  end

  def title_stylized(title)
    title.length >= 30 ? title.first(27) + "..." : title
  end

  def goal_status(maturity)
    if maturity == "0"
      "very young goals"
    elsif maturity == "1"
      "young goals"
    else
      "adult goals"
    end
  end

  def date_stylized(datetime)
    datetime.strftime('%b %d, %Y')
  end
end
