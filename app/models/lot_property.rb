# This class describes lot property value
class LotProperty
  include Mongoid::Document

  referenced_in :property # as a category_property column

  validates_presence_of :value, :if => :required?

  def required? 
    property.required?
  end
end
