class FloatProperty < NumericProperty
  include Mongoid::Slug

  field :value, :type => Float, :default => 0.0
  slug  :value

  validates_numericality_of :value, :less_than    =>  NumericCharacteristic::FIXNUM_MAX, 
                                    :greater_than => -NumericCharacteristic::FIXNUM_MAX,
end
