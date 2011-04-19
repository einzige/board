class IntegerCharacteristic < NumericCharacteristic
  field :default, :type => Integer, :default => 0

  validates_numericality_of :default
end
