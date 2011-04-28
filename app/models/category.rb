class Category
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Mongoid::Tree::Traversal
  include Mongoid::Slug
  include Mongoid::Layout::Container

  # POSITIONING 
  time_range_extended_layout

  # FIELDS
  field :name
  slug  :name
  field :description, :default => ''
  field :lots_count, :type => Integer, :default => 0

  # VALIDATIONS
  validates_presence_of :name

  # REFERENCES
  references_many :lots,                      :dependent => :destroy

  references_many :characteristics,           :dependent => :destroy

  references_many :integer_characteristics,   :dependent => :destroy
  references_many :float_characteristics,     :dependent => :destroy
  references_many :boolean_characteristics,   :dependent => :destroy
  references_many :string_characteristics,    :dependent => :destroy
  references_many :selection_characteristics, :dependent => :destroy

  references_many :operations,                :dependent => :destroy
  references_many :characteristic_containers, :dependent => :destroy

  # SCOPES
  scope :not_empty, where(:lots_count.gt => 0)

  # CALLBACKS
  before_destroy :destroy_children

  # SERVICE FUNCTIONS
  def descendant_lots
    Lot.any_in(:category_id => descendants.only(:id).map(&:id) << id)
  end                                                               

  def ancestors_operations;      ancestors_for Object::Operation               end
  def ancestors_containers;      ancestors_for Object::CharacteristicContainer end
  def ancestors_characteristics; ancestors_for Object::Characteristic          end

  # service methods
  #
  def recount_lots
    update_attribute(:lots_count, lots.count)
  end
  def self.recount_lots
    Category.all.each {|c| c.recount_lots}
  end

  # can can fix
  class << self
    alias find_by_slug! find_by_slug 
  end

  protected
  def ancestors_for a_class
    a_class.any_in(:category_id => parent_ids << id)
  end
end
