class Category
  include Mongoid::Document
  field :name

  references_many :lots

  # Selection properties
  embeds_many :selection_properties
  # Single value string input property
  embeds_many :string_properties
  # Three-state properties
  embeds_many :boolean_properties
  # Range properties
  embeds_many :numeric_properties

  validates_presence_of :name
end
