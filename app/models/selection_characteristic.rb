# -*- coding: utf-8 -*-
class SelectionCharacteristic < Characteristic
  field :includes_blank, :type => Boolean, :default => false
  field :representation

  references_and_referenced_in_many :selection_collections

  def represents? something
    something.to_s == representation
  end

  REPRESENTATIONS = {'выпадающий список' => "selectbox", 
                     'радиогруппа'       => "radiogroup"}

  validates_inclusion_of :representation, :in => REPRESENTATIONS.values, :allow_blank => false

  def selection_options
    selection_collections.map(&:collection_items).flatten
  end
end
