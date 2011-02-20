# SelectBox-like model
class SelectionField < Field
  embeds_many :options,  :class_name => "SelectionFieldOption"
end

class SelectionFieldOption
  include Mongoid::Document
  field :name
  field :value

  embedded_in :selection_property, :inverse_of => :options

  validates_presence_of :name, :value
end
