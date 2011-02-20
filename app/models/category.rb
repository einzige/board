class Category
  include Mongoid::Document
  field :name

  references_many :lots, :dependent => :destroy
  embeds_many     :characteristics

  validates_presence_of :name
end
