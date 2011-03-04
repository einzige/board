# -*- coding: utf-8 -*-
class SelectionCharacteristic < Characteristic
  field :includes_blank, :type => Boolean, :default => false
  field :representation

  references_and_referenced_in_many :selection_collections

  def represents? something
    if something.kind_of? Symbol
      something == representation.to_sym
    else
      something == representation
    end
  end

  REPRESENTATIONS = {'выпадающий список' => "selectbox", 
                     'чекбоксы'          => "checkboxes", 
                     'радиогруппа'       => "radiogroup"}

  validates_inclusion_of :representation, :in => REPRESENTATIONS.values, :allow_blank => false
end
