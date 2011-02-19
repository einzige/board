class StringLotProperty < LotProperty
  field :value

  embedded_in :lot, :inverse_of => :string_properties 

  validates_length_of :value, :minimum => 1, :maximum => 512 # FIXME: 512 to property.chars_limit
end
