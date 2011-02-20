class NumericField < Field
  FIXNUM_MAX = Float(2**(0.size * 8 -2) -1)

  field :range, :type => Boolean, :default =>  false
  field :max,   :type => Float,   :default =>  FIXNUM_MAX
  field :min,   :type => Float,   :default => -FIXNUM_MAX
  field :step,  :type => Float,   :default => 1.0

  scope :ranged,  where(:range => true)
  scope :integer, where(:_type => "IntegerField")
  scope :float,   where(:_type => "FloatField")
end
