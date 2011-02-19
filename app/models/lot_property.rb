# This class describes lot property value
class LotProperty
  include Mongoid::Document

  referenced_in :property # as a category_property column
  embedded_in   :lot, :inverse_of => :properties

  validates_presence_of :value, :if => :required?

  def required? 
    property.required?
  end
end
