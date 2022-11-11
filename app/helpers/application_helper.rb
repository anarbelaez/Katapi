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
    datetime&.strftime('%b %d, %Y')
  end

  def message(alive, dead)
    if alive > dead
      "Yay! Most of your trees are alive!"
    else
      "Oh no! Most of your trees are dead!"
    end
  end

  def porcentaje(total_tareas, total_terminadas)
   total_terminadas / total_tareas
  end

  def percentage_not_started
    (current_user.not_started_tasks_fraction * 100).to_i || 0
  end

  def percentage_in_progress
    (current_user.in_progress_tasks_fraction * 100).to_i || 0
  end

  def percentage_done
    (current_user.done_tasks_fraction * 100).to_i || 0
  end

  def health_goal(goal)
    if goal.dead?
      "Dead - RIP"
    elsif goal.dying?
      "Dying, in less than eight days I will die!"
    else
      "I am alive!"
    end
  end

  def health_goal_image(status, maturity)
    if status == false
      if maturity == "baby"
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668017718/arbol_bebe_uab5p1.png"
      elsif maturity == "young"
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668017718/arbol_young_bybm1s.png"
      else
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668017721/arbol_adulto_grrhmj.png"
      end
    else
      if maturity == "baby"
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668027465/dead_baby_tree_aul8ps.png"
      elsif maturity == "young"
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668027465/dead_young_tree_ifk4fb.png"
      else
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668027465/dead_adult_tree_xdbpyr.png"
      end
    end
  end

  def health_goals_image_url
    if current_user.tasks.present?
      not_started_tasks = current_user.tasks.not_started.count.fdiv(current_user.tasks.count)
      in_progress_tasks = current_user.tasks.in_progress.count.fdiv(current_user.tasks.count)
      done_tasks = current_user.tasks.done.count.fdiv(current_user.tasks.count)

      if not_started_tasks >= in_progress_tasks && not_started_tasks >= done_tasks
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668020023/purplebabytree_glfifh.png"
      elsif in_progress_tasks >= done_tasks && in_progress_tasks >= not_started_tasks
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668020024/purpleyoungtree_oqzkg5.png"
      else
        "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668020006/purpleadultree_fac9nn.png"
      end
    else
      "https://res.cloudinary.com/dknxl9ghi/image/upload/v1668020344/landscapewithouttree_wadq0k.png"
    end
  end
end
