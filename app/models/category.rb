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

  def characteristics_for operation # FIXME remove
    if operation
      ancestors_characteristics.any_in(:operation_id => [operation.id, nil])
    else
      ancestors_characteristics.where(:operation_id => nil)
    end
  end

  def characteristics_only_for operation # FIXME remove
    operation ? ancestors_characteristics.where(:operation_id => operation.id) : []
  end

  def ancestors_operations;      ancestors_for Object::Operation               end
  def ancestors_containers;      ancestors_for Object::CharacteristicContainer end
  def ancestors_characteristics; ancestors_for Object::Characteristic          end

  # FIXME: move search logic into Lot model
  # FIXME: use searchlogic instead :)
  def search_lots params={}, conditions=nil
    criteria = descendant_lots
    criteria = criteria.where(conditions) unless conditions.nil?

    return criteria if params.nil? || params.empty?

    matches = []

    params.reject! { |k,v| v.empty? }
    params.each do |cid, value|
      if value.is_a? Array
        if Characteristic.find_by_slug(cid).numeric?
          matches << {:slug  => cid, :value => {'$in' => value.map(&:to_f)}}
        else
          matches << {:slug  => cid, :value => {'$in' => value.map(&:to_s)}}
        end
      else 
        match = cid.match(/(.+)_less_than$/) 
        unless match.nil?
          matches << {:slug  => match[1], :value => {'$lte' => value.to_f}}
        else
          match = cid.match(/(.+)_greater_than$/)
          unless match.nil?
            matches << {:slug  => match[1], :value => {'$gte' => value.to_f}}
          else
            if Characteristic.find_by_slug(cid).numeric?
              matches << {:slug => cid, :value => value.to_f}
            else
              matches << {:slug => cid, :value => value.to_s}
            end
          end # end greater_than
        end # end less_than
      end # endif
    end # endeach

    criteria.where("properties" => {"$all" => matches.map {|r| {'$elemMatch' => r} }})
  end

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
