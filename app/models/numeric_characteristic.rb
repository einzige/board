class NumericCharacteristic < Characteristic
  FIXNUM_MAX = Float(2**(0.size * 8 -2) -1)
  GROSS = 9999 # FIXME: remove

  field :range,   :type => Boolean, :default =>  false
  # Cache fields
  field :max,     :type => Float,   :default => -FIXNUM_MAX #\
                                                              #--- inverse to set
  field :min,     :type => Float,   :default =>  FIXNUM_MAX #/
  # As a GUI element increment possability
  field :step,    :type => Float,   :default =>  1.0
  field :r_limit, :type => Float,   :default =>  FIXNUM_MAX #\
                                                              #--- and no inverse here
  field :l_limit, :type => Float,   :default => -FIXNUM_MAX #/

  field :default, :type => Float,   :default => 0.0

#  field :units
  field :measure

  scope :ranged,  where(:range => true)
  scope :integer, where(:_type => "IntegerCharacteristic")
  scope :float,   where(:_type => "FloatCharacteristic")

  def ranged?; range end

  before_update do
    self[:min] = l_limit if l_limit > min
    self[:max] = r_limit if r_limit < max
  end

end
