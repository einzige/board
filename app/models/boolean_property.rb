class BooleanProperty < Property
  embedded_in :category, :inverse_of => :boolean_properties
end
