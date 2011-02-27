class SelectionCharacteristicOption
  include Mongoid::Document
  field :name
  field :value

  embedded_in :selection_characteristic, :inverse_of => :selection_options

  validates_presence_of :name, :value
end
