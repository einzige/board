class Operation
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Layout::Container

  # POSITIONING 
  time_range_extended_layout

  field :name
  slug  :name
  field :description

  referenced_in :category
  references_and_referenced_in_many :lots
  references_many :characteristics

  validates_presence_of :name
  validates_presence_of :category

  def self.for category
    Operation.any_in(:category_id => category.ancestors.only(:id).map(&:id) \
                                  << category.id)
  end

  class << self
    alias find_by_slug! find_by_slug 
  end
end
