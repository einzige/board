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
  references_many :characteristics,           :dependent => :destroy
  references_many :characteristic_containers, :dependent => :destroy

  validates_presence_of :name
  # validates_presence_of :category
  
  def ancestors_characteristics include_shared = false
    criteria = Characteristic.where(:category_id.in => category.parent_ids << category.id) 

    if include_shared
      criteria.for_operation(self)
    else
      criteria.only_for_operation(self)
    end
  end

  class << self
    alias find_by_slug! find_by_slug 
  end
end
