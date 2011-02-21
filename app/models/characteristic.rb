class Characteristic
  include Mongoid::Document
  field :name
  field :required,   :type => Boolean, :default => false
  field :primary,    :type => Boolean, :default => false
  field :position,   :type => Integer, :default => 0
  field :lots_count, :type => Integer, :default => 0

  embedded_in :category, :inverse_of => :characteristics
  
  validates_presence_of   :name 
  validates_uniqueness_of :name

  scope :boolean, where(:_type => "BooleanCharacteristic")
  scope :integer, where(:_type => "IntegerCharacteristic")
  scope :float,   where(:_type => "FloatCharacteristic")
  scope :string,  where(:_type => "StringCharacteristic")
end
