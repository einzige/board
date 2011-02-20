class Characteristic
  include Mongoid::Document
  characteristic :name
  characteristic :required, :type => Boolean, :default => false
  characteristic :primary,  :type => Boolean, :default => false
  characteristic :ord,      :type => Integer, :default => 0

  embedded_in :category, :inverse_of => :characteristics
  
  validates_presence_of   :name 
  validates_uniqueness_of :name

  scope :boolean, where(:_type => "BooleanCharacteristic")
  scope :integer, where(:_type => "IntegerCharacteristic")
  scope :float,   where(:_type => "FloatCharacteristic")
  scope :string,  where(:_type => "StringCharacteristic")
end
