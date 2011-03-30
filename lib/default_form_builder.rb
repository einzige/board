class DefaultFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper

  def label method, title = method.name, options = {}
    if method.kind_of? Characteristic
      options[:class] = "#{'required' if method.required?}" #FIXME logic
      super method.id, method.name, options
    else
      super method, title, options
    end
  end

  def tristate characteristic, state = nil
    attrs   = attrs_for(characteristic)
    options = attrs.merge({:class => attrs[:class] + ' tristate'})

    checked = state.nil? ? (characteristic.default.nil? ? false : true) : true
    value   = checked    ? (state.nil? ? (characteristic.default? ? '1' : '0') : state) : ''

    check_box_tag "#{@object_name}[#{characteristic.slug}]", value, checked, options
  end

  def selection characteristic, value = nil
    case characteristic.representation
    when 'radiogroup' then
      characteristic.selection_options.map do |o|
          radio_button_tag(characteristic.slug, o.value, value == o.value, attrs_for(characteristic)) + \
          o.value
      end.join(" ").html_safe
    when 'selectbox' then
      select( 
          @object_name,
          characteristic.slug, 
          options_from_collection_for_select(characteristic.selection_options, "value", "value", value),
          attrs_for(characteristic).merge(:include_blank => characteristic.required? ? false : characteristic.includes_blank?)
      )
    end
  end
  
  def numeric_lt characteristic, value = nil
    case characteristic.class
    when IntegerCharacteristic then integer_lt characteristic, value
    when FloatCharacteristic   then float_lt   characteristic, value
    end
  end
  def numeric_gt characteristic, value = nil
    case characteristic.class
    when IntegerCharacteristic then integer_gt characteristic, value
    when FloatCharacteristic   then float_gt   characteristic, value
    end
  end
  def numeric characteristic, value = nil
    case characteristic.class
    when IntegerCharacteristic then integer characteristic, value
    when FloatCharacteristic   then float   characteristic, value
    end
  end

  def integer_gt characteristic, value = nil
    text_field "#{characteristic.slug}_greater_than",
                  integer_attrs_for(characteristic, value || lim_or_min(characteristic))
  end
  def integer_lt characteristic, value = nil
    text_field "#{characteristic.slug}_less_than", 
                  integer_attrs_for(characteristic, value || lim_or_max(characteristic))
  end
  def integer characteristic, value = nil
    text_field characteristic.slug, 
                  integer_attrs_for(characteristic, value || characteristic.default)
  end

  def float_gt characteristic, value = nil
    text_field "#{characteristic.slug}_greater_than"
                  float_attrs_for(characteristic, value || lim_or_min(characteristic.l_limit))
  end
  def float_lt characteristic, value = nil
    text_field "#{characteristic.slug}_less_than", 
                  float_attrs_for(characteristic, value || lim_or_max(characteristic.r_limit))
  end
  def float characteristic, value = nil
    text_field characteristic.slug, 
                  float_attrs_for(characteristic, value || characteristic.default)
  end

  private 
  def lim_or_min characteristic
    if characteristic.min >= characteristic.r_limit
      characteristic.l_limit
    else
      characteristic.min
    end
  end
  def lim_or_max characteristic
    if characteristic.max <= characteristic.l_limit
      characteristic.r_limit
    else
      characteristic.max
    end
  end
  def attrs_for characteristic, value = nil
    {
    :required => characteristic.required? ? 'required' : 'not-required',
    :class => "#{'required' if characteristic.required?} #{'primary' if characteristic.primary?}"
    }
  end
  def float_attrs_for characteristic, value = nil
    {
    :value => (value || characteristic.default),
    :min   => characteristic.l_limit, 
    :max   => characteristic.r_limit, 
    :step  => characteristic.step
    }.merge(attrs_for characteristic, value)
  end
  def integer_attrs_for characteristic, value = nil
    attrs = float_attrs_for(characteristic, value.nil? ? value : value.to_i)
    attrs.each { |k,v| attrs[k] = v.to_i if v.kind_of? Numeric }
  end
end

