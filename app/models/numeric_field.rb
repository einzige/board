class NumericCharacteristic < Characteristic
  FIXNUM_MAX = Float(2**(0.size * 8 -2) -1)

  characteristic :range,   :type => Boolean, :default =>  false
  # Cache characteristics
  characteristic :max,     :type => Float,   :default => -FIXNUM_MAX #\
                                                              #--- makes inverse to set
  characteristic :min,     :type => Float,   :default =>  FIXNUM_MAX #/
  # As a GUI element increment possability
  characteristic :step,    :type => Float,   :default =>  1.0
  characteristic :r_limit, :type => Float,   :default =>  FIXNUM_MAX #\
                                                              #--- and no inverse here
  characteristic :l_limit, :type => Float,   :default => -FIXNUM_MAX #/

  scope :ranged,  where(:range => true)
  scope :integer, where(:_type => "IntegerCharacteristic")
  scope :float,   where(:_type => "FloatCharacteristic")
end
