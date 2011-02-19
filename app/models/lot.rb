class Lot
  include Mongoid::Document
  field :name
  field :description
  
  referenced_in :user
  referenced_in :category

  # Selection properties
  embeds_many :string_properties,  :class_name => "StringLotProperty"
  # Range properties
  embeds_many :numeric_properties, :class_name => "NumericLotProperty"
  # Three-state properties
  embeds_many :boolean_properties, :class_name => "BooleanLotProperty"

  validates_presence_of :name
end
