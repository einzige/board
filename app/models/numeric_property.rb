class NumericProperty < Property
  validates_numericality_of :value, :less_than    =>  NumericCharacteristic::FIXNUM_MAX, 
                                    :greater_than => -NumericCharacteristic::FIXNUM_MAX

  scope :integer, where(:characteristic.matches => {:_type => "IntegerCharacteristic"})
  scope :float,   where(:characteristic.matches => {:_type => "FloatCharacteristic"})

  def integer?; _type == "IntegerProperty"
  end
  def float?;   _type == "FloatProperty"
  end

  after_create :update_extremums

  protected 
    def update_extremums
      characteristic.update_attribute(:max, self.value) if value > characteristic.max
      characteristic.update_attribute(:min, self.value) if value < characteristic.min
    end
end
