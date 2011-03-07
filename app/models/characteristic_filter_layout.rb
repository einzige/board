class CharacteristicFilterLayout < CharacteristicLayout
  embedded_in :characteristic, :inverse_of => :filter_layout
end
