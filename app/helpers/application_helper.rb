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
    res = category.ancestors_and_self.map do |c| 
      {
        :name => c.name, 
        :link => c 
      }
    end    
    res << {
             :name  => operation.name, 
             :link  => category_path(category) + "?operation=#{operation.slug}", 
             :class => 'red'
           } if operation
    res
  end

  def style_for something
    if something.kind_of? Characteristic
      style =  "left         :#{something.form_layout.x}px;"       +  
               "top          :#{something.form_layout.y}px;"       +
               "width        :#{something.form_layout.width}px;"   +
               "height       :#{something.form_layout.height}px;"  +
               "border-color :#{something.operation ? 'blue' : 'orange'}"
    else 
      if something.kind_of? CharacteristicContainer
        style =  "left         :#{something.form_layout.x}px;"       +  
                 "top          :#{something.form_layout.y}px;"       +
                 "width        :#{something.form_layout.width}px;"   +
                 "height       :#{something.form_layout.height}px;"  +
                 "border-color :#{something.operation ? 'blue;' : 'orange;'}"
      end
    end
    style
  end

  def check_box_options_for something
    options = {}

    if something.kind_of? Characteristic
      checked = something.default

      options[:checked] = 'checked' unless checked.nil?
      options[:class]   = "tristate #{'primary' if something.primary? }"
      options[:value]   =  checked.nil? ? '' : (something.default ? '1' : '0')
    end

    options
  end

end
