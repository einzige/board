# SelectBox-like model
class SelectionCharacteristic < Characteristic
  field :includes_blank,       :type => Boolean, :default => false
  field :representations_mask, :type => Integer, :default => 0

  embeds_many :options, :class_name => "SelectionCharacteristicOption"

  REPRESENTATIONS = [:selectbox, :checkboxes, :radiogroup]

  def representation=(r)
    representations_mask = REPRESENTATIONS.index(r)
  end
  def representation
    REPRESENTATIONS[representations_mask].to_sym
  end
  def represents? something
    something.to_sym == representation
  end
end

class SelectionCharacteristicOption
  include Mongoid::Document
  field :name
  field :value

  embedded_in :selection_field, :inverse_of => :options

  validates_presence_of :name, :value
end
