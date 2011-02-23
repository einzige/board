class Lot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name
  field :description
  field :serial_number
  slug  :name
  
  referenced_in :user
  referenced_in :category
  referenced_in :operation
  embeds_many   :properties

  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :operation
  validates_length_of   :name, :minimum => 2, :maximum => 512
  validates_length_of   :description, :maximum => 6000

  before_create :set_serial_number
  after_create  :increase_category_lots_count
  after_destroy :decrease_category_lots_count

  protected
    def set_serial_number
      serial_number = category.lots_count + 1
    end
    def increase_category_lots_count
      category.inc(:lots_count, 1)
    end
    def decrease_category_lots_count
      category.inc(:lots_count, -1)
    end
  
end
