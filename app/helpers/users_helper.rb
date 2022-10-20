module UsersHelper
  # Necesitamos agregar los siguientes metodos que sobreescriben algunos metodos de
  # la gema Devise

  def resource_name
    :user
  end

  def resource
    # @resource ||= User.new
    @resource ||= current_user
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
