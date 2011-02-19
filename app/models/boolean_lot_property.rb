class BooleanLotProperty < LotProperty
  field :value, :type => Boolean

  embedded_in :lot, :inverse_of => :boolean_properties
end


