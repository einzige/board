class IntegerProperty < NumericProperty
  field :value, :type => Integer, :default => 0
  validates_numericality_of :value, :less_than    =>  NumericField::FIXNUM_MAX, 
                                    :greater_than => -NumericField::FIXNUM_MAX,
                                    :only_integer => true
end
