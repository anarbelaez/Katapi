class UsersController < ApplicationController
  def activity
    # TODO:
    # Mostrar las tareas - calendario
    @tasks = current_user.tasks
    # Mostrar rendimiento
    # Mostar las goals
    @goals = current_user.goals
    # authorize @tasks
    authorize @goals
    authorize @tasks

    # def search
    #   if params[:query].present?
    #     @query = params[:query]
    #     @products = Product.search(params[:query]).available
    #   else
    #     @products = Product.available
    #   end
    # end
  end

  def show
    # Mi informacion
    # Editar mi perfil
    # Notificaciones
    @user = current_user
    authorize @user
  end


end
