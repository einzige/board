class CharacteristicContainer
  #FIXME: i must be in some operation
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Layout::Container

  default_layout

  references_many :characteristics
  referenced_in   :category
  referenced_in   :operation

  field :name
  slug  :name
  field :description

  validates_presence_of :name

  scope :for_operation, lambda {|operation| where(:operation_id.in => [operation ? operation.id : nil, nil])}

  class << self
    alias find_by_slug! find_by_slug 
  end
end
