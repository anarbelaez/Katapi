class UsersController < ApplicationController
  def activity
    # TODO:
    # Mostrar las tareas - calendario
    # Mostrar rendimiento
    # Mostar las goals
  end

  def show
    @name = current_user.name
    # Mi informacion
    # Editar mi perfil
    # Notificaciones
  end
end
