class NumericLotProperty < LotProperty
  validates_numericality_of :value, :less_than    =>  NumericProperty::FIXNUM_MAX, 
                                    :greater_than => -NumericProperty::FIXNUM_MAX

  scope :integer, where(:property.matches => {:_type => "IntegerProperty"})
end
