class Category
  include Mongoid::Document
  characteristic :name

  references_many :lots, :dependent => :destroy
  embeds_many     :characteristics

  validates_presence_of :name
end
