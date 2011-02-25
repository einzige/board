class Characteristic
  include Mongoid::Document
  include Mongoid::Slug
  field :name
  slug  :name
  field :required,   :type => Boolean, :default => false
  field :primary,    :type => Boolean, :default => false
  field :position,   :type => Integer, :default => 0
  field :lots_count, :type => Integer, :default => 0

  referenced_in :category
  referenced_in :operation
  
  validates_presence_of     :name 
  validates_presence_of     :category
  validates_numericality_of :position
  validates_numericality_of :lots_count

  scope :boolean, where(:_type => "BooleanCharacteristic")
  scope :integer, where(:_type => "IntegerCharacteristic")
  scope :float,   where(:_type => "FloatCharacteristic")
  scope :string,  where(:_type => "StringCharacteristic")

  scope :shared,  where(:operation_id => nil)
  scope :for_operation, lambda {|operation| where(:operation_id => operation.id)}

  def inc_lots_count
    inc(:lots_count, 1)
  end
  def dec_lots_count
    inc(:lots_count, -1)
  end
end
