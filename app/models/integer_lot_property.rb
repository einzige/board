class IntegerLotProperty < NumericLotProperty
  field :value, :type => Integer, :default => 0
  validates_numericality_of :value, :less_than    =>  NumericProperty::FIXNUM_MAX, 
                                    :greater_than => -NumericProperty::FIXNUM_MAX,
                                    :only_integer => true
end
