module ApplicationHelper
  # DEVISE ----------------------------
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # ENDOF DEVISE ----------------------
  #

  def breads_for category, operation = nil
    category.ancestors_and_self.map do |c| 
      {
        :name => c.name, 
        :link => c 
      }
    end << ({
             :name  => operation.name, 
             :link  => category_path(category) + "?operation=#{operation.slug}", 
             :class => 'red'
           } if operation)
  end

#  def operation_path o; "?operation=#{o.slug}" end
end
