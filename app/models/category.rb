class Category
  include Mongoid::Document
  field :name

  references_many :lots, :dependent => :destroy
  embeds_many     :fields

  validates_presence_of :name
end
