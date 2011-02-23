class Characteristic
  include Mongoid::Document
  field :name
  field :required,   :type => Boolean, :default => false
  field :primary,    :type => Boolean, :default => false
  field :position,   :type => Integer, :default => 0
  field :lots_count, :type => Integer, :default => 0

  embedded_in   :category, :inverse_of => :characteristics
  referenced_in :operation
  
  validates_presence_of     :name 
  validates_uniqueness_of   :name
  validates_associated      :category
  validates_numericality_of :position
  validates_numericality_of :lots_count

  scope :boolean, where(:_type => "BooleanCharacteristic")
  scope :integer, where(:_type => "IntegerCharacteristic")
  scope :float,   where(:_type => "FloatCharacteristic")
  scope :string,  where(:_type => "StringCharacteristic")

  def inc_lots_count
    update_attribute(:lots_count, characteristic.lots_count + 1)
  end
  def dec_lots_count
    update_attribute(:lots_count, characteristic.lots_count - 1)
  end
end
