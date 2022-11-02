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

  def porcentaje(total_tareas, total_terminadas)
   total_terminadas / total_tareas
  end

  def percentage_not_started
    all_tasks = @tasks.all.count
    (@tasks.not_started.count.fdiv(all_tasks)*100).to_i
  end

  def percentage_in_progress
    all_tasks = @tasks.all.count
    (@tasks.in_progress.count.fdiv(all_tasks)*100).to_i
  end

  def percentage_done
    all_tasks = @tasks.all.count
    (@tasks.done.count.fdiv(all_tasks)*100).to_i
  end


end
