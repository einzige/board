class Lot
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description
  
  referenced_in :user
  referenced_in :category

  embeds_many :properties

  validates_presence_of :name

  def to_param
    "#{id}-#{name.parameterize}"
  end

  after_create  :increase_category_lots_count
  after_destroy :decrease_category_lots_count

  protected
    def increase_category_lots_count
      category.update_attribute(:lots_count, category.lots_count + 1)
      #category.inc(:lots_count, 1)
    end
    def decrease_category_lots_count
      category.update_attribute(:lots_count, category.lots_count - 1)
      #category.inc(:lots_count, -1)
    end
  
end
