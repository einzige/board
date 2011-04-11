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
  
  def ancestors_characteristics
    category.characteristics_for(self)
  end
  def all_characteristics
    category.ancestors_characteristics.where(:operation_id.in => [nil, id])
  end
  def all_characteristics_for category
    category.ancestors_characteristics.where(:operation_id.in => [nil, id])
  end
  def characteristics_for category
    category.ancestors_characteristics.where(:operation_id => id)
  end

  class << self
    alias find_by_slug! find_by_slug 
  end
end
