class CharacteristicFormLayout < CharacteristicLayout
  embedded_in :characteristic, :inverse_of => :form_layout
end
