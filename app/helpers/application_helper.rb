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
    res = category.ancestors.map do |c| 
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

  def remote_forgery_protection
    javascript_tag "var AUTH_TOKEN = #{form_authenticity_token.inspect};" if protect_against_forgery?
  end

  def form_style_for something
    style_for something, "form_layout"
  end
  def filter_style_for something
    style_for something, "filter_layout"
  end

  def style_for something, layout = 'form_layout'
    if something.kind_of? Characteristic
      style =  "left         :#{something.send(layout).x}px;"       +  
               "top          :#{something.send(layout).y}px;"       +
               "width        :#{something.send(layout).width}px;"   +
               "height       :#{something.send(layout).height}px;"  +
               "border-color :#{something.operation ? 'blue' : 'orange'}"
    else 
      if something.kind_of? CharacteristicContainer
        style =  "left         :#{something.send(layout).x}px;"       +  
                 "top          :#{something.send(layout).y}px;"       +
                 "width        :#{something.send(layout).width}px;"   +
                 "height       :#{something.send(layout).height}px;"  +
                 "border-color :#{something.operation ? 'blue;' : 'orange;'}"
      end
    end
    style
  end

  def link_to_new_lot
    @category ? new_category_lot_path(@category) : new_lot_path
  end

end
