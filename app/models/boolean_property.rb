class BooleanProperty < Property
  field :value, :type => Boolean

  validates_presence_of :value
end


