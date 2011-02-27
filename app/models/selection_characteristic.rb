# SelectBox-like model
class SelectionCharacteristic < Characteristic
  field :includes_blank,       :type => Boolean, :default => false
  field :representation

  embeds_many :selection_options, :class_name => "SelectionCharacteristicOption"

  def represents? something
    if something.kind_of? Symbol
      something == representation.to_sym
    else
      something == representation
    end
  end

  REPRESENTATIONS = ["selectbox", "checkboxes", "radiogroup"]
  validates_inclusion_of :representation, :in => REPRESENTATIONS, :allow_blank => false
end
