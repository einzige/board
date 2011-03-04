class IntegerProperty < NumericProperty
  include Mongoid::Slug

  field :value, :type => Integer, :default => 0
  slug  :value

  validates_numericality_of :value, :less_than    =>  NumericCharacteristic::FIXNUM_MAX, 
                                    :greater_than => -NumericCharacteristic::FIXNUM_MAX,
                                    :only_integer => true
end
