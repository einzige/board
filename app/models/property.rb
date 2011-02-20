# This class describes lot property value
class Property
  include Mongoid::Document

  referenced_in :field # as a category_property column
  key :field_id
  def field
    lot.category.fields.criteria.id(field_id).first # FIXME: many calls?
  end

  embedded_in :lot, :inverse_of => :properties

  validates_presence_of :field_id
  validates_presence_of :field
  validates_presence_of :value, :if => :required?

  def required? 
    field.required?
  end

  scope :boolean, where(:_type => "BooleanProperty")
  scope :integer, where(:_type => "IntegerProperty")
  scope :float,   where(:_type => "FloatProperty")
  scope :string,  where(:_type => "StringProperty")
end
