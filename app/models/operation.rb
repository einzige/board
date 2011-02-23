class Operation
  include Mongoid::Document
  field :name

  embedded_in :category, :inverse_of => :operations
  
=begin
  def properties
    category.properties.where(:operation_id => id)
  end
=end

  validates_presence_of :name
  validates_presence_of :category #FIXME: use validation to the parent collection
end
