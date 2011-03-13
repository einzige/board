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
    Lot.any_in(:category_id => descendants.only(:id).map(&:id) << id) # FIXME:-+
  end                                                                 #        |
  def ancestors_characteristics                                       #        |
    Characteristic.any_in(:category_id => parent_ids << id) # <----------------+
  end
  def characteristics_for operation
    if operation
      ancestors_characteristics.any_in(:operation_id => [operation.id, nil])
    else
      ancestors_characteristics.where(:operation_id => nil)
    end
  end
  def characteristics_only_for operation
    operation ? ancestors_characteristics.where(:operation_id => operation.id) : []
  end
  def shared_characteristics
    ancestors_characteristics.where(:operation_id => nil)
  end

  def ancestors_operations
    Category.any_in(:_id => parent_ids << id)
            .only(&:operations)
            .map( &:operations).flatten
  end
  def ancestors_containers #OPTIMIZE use ancestors_and self instead? 
    Category.any_in(:_id => parent_ids << id)
            .only(&:characteristic_containers)
            .map( &:characteristic_containers).flatten
  end

#      .----------------.
#  ____|.------+-------.|__________________
# | 1'9||'7""6"|5"""4""||3""""""2'''''''''1|
# |____||______|_______||__________________|_______
#   \  || | 1''|''''''2||""""3""""4"""5""6""7'8'9'1|_____
#  _/__||_|____|_______||__________________________|     |
# | 1''||'''''2|"""""3"||"4"""5""6""7'8'9'1|-------`     |
# |____|`------+-------`|__________________|             |
#  \___\================/_________________/              |
#       `--------------`                                 |
#    aul.ru                                              |
#                         /\                             |
#                        #  \                            |
  def search_lots params={}, operation=nil #\____________/
    # There are NO LOGIC>-------------------------------------+ 
    #                                                         |    
    # params shold be in the given storage:    _              |
    # ingeter   => {characteristic_id => value} \             V 
    # float     => {characteristic_id => value}  \_____USES_SIMPLE_{matches}.where______OR
    # string    => {characteristic_id => value}  /                                      |
    # boolean   => {characteristic_id => value}_/                                       V
    # checkers  => {characteristic_id[] => [1,2,3,4...]}--------------------> uses {in}.where
    # any_other => {characteristic_id_(less_than|greater_than)}-------------> uses {gt|lt}.where
    # __________________________________________________________________________________________

    criteria = descendant_lots
    criteria = criteria.where(:operation_ids => operation.id) unless operation.nil?

    return criteria if params.nil?

    params.each do |cid, value|
      if value.is_a? Array
        criteria = criteria.in({"properties.characteristic_id" => [cid], 
                                            "properties.slug"  => value.to_s.parameterize})
      else 
        match = cid.match(/(.+)_less_than$/)                                    # lte-+-fix
        unless match.nil?                                                       #     |
          criteria = criteria.where({"properties.characteristic_id" => match[1],#     V
                                         :properties.lte => {:value => value.to_f + 10**-10}}) if match.length > 1
        else
          match = cid.match(/(.+)_greater_than$/)
          unless match.nil?
            criteria = criteria.where({"properties.characteristic_id" => match[1], 
                                           :properties.gte => {:value => value.to_f}}) if match.length > 1
          else
            # do simple where
            criteria = criteria.where({"properties.characteristic_id" => cid, 
                                                   "properties.slug"  => value.to_s.parameterize})
          end # end greater_than
        end # end less_than
      end # endif
    end # endeach
    criteria
  end


  # service methods
  #
  def recount_lots
    update_attribute(:lots_count, lots.count)
  end
  def self.recount_lots
    Category.all.each {|c| c.recount_lots}
  end

  class << self
    alias find_by_slug! find_by_slug 
  end
end
