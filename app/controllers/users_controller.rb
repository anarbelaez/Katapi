class UsersController < ApplicationController
  def activity
    # TODO:
    # Mostrar las tareas - calendario
    # Mostrar rendimiento
    # Mostar las goals
  end

  def show
    # Mi informacion
    # Editar mi perfil
    # Notificaciones
    @name = current_user.name
    @nickname = current_user.nickname
  end
end
