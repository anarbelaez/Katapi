class UsersController < ApplicationController
  def activity
    # TODO:
    # Mostrar las tareas - calendario
    @tasks = Task.all
    # Mostrar rendimiento
    # Mostar las goals
    @goals = Goal.all

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
    @name = current_user.name
    @nickname = current_user.nickname
  end
end
