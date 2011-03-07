class Lot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name
  slug  :name
  field :description
  field :serial_number
  
  referenced_in                     :user
  referenced_in                     :category
  references_and_referenced_in_many :operations
  embeds_many                       :properties
  embeds_one                        :contact

  validates_presence_of :name
  validates_presence_of :category
  validates_length_of   :operation_ids, :minimum => 1
  validates_length_of   :name, :minimum => 2, :maximum => 512
  validates_length_of   :description, :maximum => 6000

  before_create  :set_serial_number
  after_create   :increase_category_lots_count
  before_destroy :clean_operations
  after_save     :save_operations
  after_destroy  :decrease_category_lots_count

  protected
    def set_serial_number
      serial_number = category.lots_count + 1
    end
    def increase_category_lots_count
      category.inc(:lots_count, 1)
    end
    def decrease_category_lots_count
      category.inc(:lots_count, -1) unless category.nil?
    end

    def save_operations
      operations.each { |o| o.save if o.changed? }
    end
    def clean_operations
      operations.each { |o| o.lot_ids.delete(id) }
    end
end
