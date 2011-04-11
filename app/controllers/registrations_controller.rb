class RegistrationsController < Devise::RegistrationsController
  
  def create
    super
    session[:omniauth] = nil unless resource.new_record?
  end
    
  def update
    if password_needed?
      set_flash_message :notice, :updated
      sign_in resource_name, resource
      redirect_to :back
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end
    
  private  

  def password_needed?
    resource.update_with_password(params[resource_name])\
  end
end
