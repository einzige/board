# SelectBox-like model
class SelectionProperty < Property
  embeds_many :options,  :class_name => "SelectionPropertyOption"
end

class SelectionPropertyOption
  include Mongoid::Document
  field :name
  field :value

  embedded_in :selection_property, :inverse_of => :options

  validates_presence_of :name, :value
end
