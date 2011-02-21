# SelectBox-like model
class SelectionCharacteristic < Characteristic
  embeds_many :options,  :class_name => "SelectionCharacteristicOption"
end

class SelectionCharacteristicOption
  include Mongoid::Document
  field :name
  field :value

  embedded_in :selection_field, :inverse_of => :options

  validates_presence_of :name, :value
end
