class StringProperty < Property
  field :value
  validates_length_of :value, :minimum => 1, :maximum => 512 # FIXME: 512 to property.chars_limit
end
