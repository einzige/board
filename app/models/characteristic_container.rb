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
  field :collapsed, :type => Boolean, :default => false

  before_destroy do
    characteristics.each {|c| c.update_attribute(:characteristic_container_id, nil)}
  end

  validates_presence_of :name

  scope :for_operation,      (lambda do |operation| 
    where(:operation_id.in => [operation ? operation.id : nil, nil])
  end)
  scope :only_for_operation, (lambda do |operation| 
    where(:operation_id    =>  operation ? operation.id : nil)
  end)
  scope :without_operation, where(:operation_id => nil)

  class << self
    alias find_by_slug! find_by_slug 
  end

  def empty?
    characteristics.count < 1
  end
end