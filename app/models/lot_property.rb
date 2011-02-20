# This class describes lot property value
class LotProperty
  include Mongoid::Document

  referenced_in :property # as a category_property column
  key :property_id
  def property
    lot.category.properties.criteria.id(property_id).first # FIXME: many calls?
  end

  embedded_in :lot, :inverse_of => :properties

  validates_presence_of :property_id
  validates_presence_of :value, :if => :required?

  def required? 
    property.required?
  end

  scope :boolean, where(:_type => "BooleanLotProperty")
  scope :integer, where(:_type => "IntegerLotProperty")
  scope :float,   where(:_type => "FloatLotProperty")
  scope :string,  where(:_type => "StringLotProperty")
end
