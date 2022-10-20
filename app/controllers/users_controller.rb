class UsersController < ApplicationController
  def activity
    # TODO:
    # Mostrar las tareas - calendario
    # Mostrar rendimiento
    # Mostar las goals
  end

  def show
    # Mi informacion
    @name = current_user.name
    @nickname = current_user.nickname
    # Editar mi perfil
    # Notificaciones
  end
end
