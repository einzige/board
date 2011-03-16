class FilterFormBuilder < DefaultFormBuilder
  #FIXME: checkboxes here
  def selection characteristic, value
    case characteristic.representation
    when 'radiogroup' then
      characteristic.selection_options.map do |o|
          radio_button_tag(characteristic.slug, o.value, value == o.value) + \
          o.value
      end.join(" ").html_safe
    when 'selectbox' then
      select( 
          @object_name,
          characteristic.slug, 
          options_from_collection_for_select(characteristic.selection_options, "value", "value", value),
          :include_blank => true
      )
    end
  end
end

