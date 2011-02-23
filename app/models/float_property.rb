class FloatProperty < NumericProperty
  field :value, :type => Float, :default => 0.0

  validates_numericality_of :value, :less_than    =>  NumericCharacteristic::FIXNUM_MAX, 
                                    :greater_than => -NumericCharacteristic::FIXNUM_MAX,
end
