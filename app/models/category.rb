class Category
  include Mongoid::Document
  field :name

  references_many :lots, :dependent => :destroy
  embeds_many     :properties

  validates_presence_of :name
end
