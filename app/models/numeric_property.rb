class NumericProperty < Property
  validates_numericality_of :value, :less_than    =>  NumericField::FIXNUM_MAX, 
                                    :greater_than => -NumericField::FIXNUM_MAX

  scope :integer, where(:field.matches => {:_type => "IntegerField"})
  scope :float,   where(:field.matches => {:_type => "FloatField"})

  def integer?
    _type == "IntegerProperty"
  end
  def float?
    _type == "FloatProperty"
  end

end
