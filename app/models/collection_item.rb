class CollectionItem
  include Mongoid::Document
  include Mongoid::Slug

  field :value
  slug  :value
  field :selected, :type => Boolean, :default => false

  embedded_in :selection_collection, :inverse_of => :collection_items

  validates_presence_of :value

  class << self
    alias find_by_slug! find_by_slug 
  end
end
