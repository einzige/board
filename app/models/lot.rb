class Lot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name
  field :description
  slug  :name
  
  referenced_in :user
  referenced_in :category

  embeds_many :properties

  validates_presence_of :name
  validates_presence_of :category
  validates_length_of   :name, :minimum => 2, :maximum => 512
  validates_length_of   :description, :maximum => 6000

  after_create  :increase_category_lots_count
  after_destroy :decrease_category_lots_count

  protected
    def increase_category_lots_count
      category.inc(:lots_count, 1)
    end
    def decrease_category_lots_count
      category.inc(:lots_count, -1)
    end
  
end
