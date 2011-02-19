class NumericLotProperty < LotProperty
  embedded_in :lot, :inverse_of => :numeric_properties

  validates_numericality_of :value, :less_than    =>  NumericProperty::FIXNUM_MAX, 
                                    :greater_than => -NumericProperty::FIXNUM_MAX

  scope :integer, where(:property.matches => {:_type => "IntegerProperty"})
end
