class SelectionCollection
  include Mongoid::Document
  include Mongoid::Slug

  field :name
  slug  :name
  
  embeds_many :collection_items

  validates_presence_of :name

  def parse_items str
    str.split("\n").each do |i|
      self.collection_items.create({:value => i})
    end
  end
end