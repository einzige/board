# SelectBox-like model
class SelectionProperty < Property
  embeds_many :options,  :class_name => "SelectionPropertyOption"
  embedded_in :category, :inverse_of => :selection_properties
end

class SelectionPropertyOption
  include Mongoid::Document
  field :name
  field :value

  embedded_in :selection_property, :inverse_of => :options

  validates_presence_of :name, :value
end
