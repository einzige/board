class StringProperty < Property
  include Mongoid::Slug

  field :value
  slug  :value

  validates_length_of :value, :minimum => 1, :maximum => 512 # FIXME: 512 to property.chars_limit
  validates_presence_of :value, :if => :required?
end
