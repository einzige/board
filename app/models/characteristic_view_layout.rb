class CharacteristicViewLayout < CharacteristicLayout
  embedded_in :characteristic, :inverse_of => :view_layout
end
