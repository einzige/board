class FloatCharacteristic < NumericCharacteristic
  field :default, :type => Float, :default => 0.0

  validates_numericality_of :default
end
