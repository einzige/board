class Category
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Mongoid::Tree::Traversal
  include Mongoid::Slug

  # FIELDS
  field :name
  field :lots_count, :type => Integer, :default => 0
  slug  :name

  # VALIDATIONS
  validates_presence_of :name

  # REFERENCES
  references_many :lots, :dependent => :destroy
  embeds_many     :characteristics
  embeds_many     :operations

  # SCOPES
  scope :not_empty, where(:lots_count.gt => 0)

  # CALLBACKS
  before_destroy :destroy_children

  # SERVICE FUNCTIONS
  def descentant_lots
    Lot.any_in(:category_id => descendants.only(:id).map(&:id))
  end

  def ancestors_operations #OPTIMIZE
    ops = []
    ancestors.each do |a|
      a.operations.each {|o| ops << o}
    end
    ops
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
#                       /\                               |
#                      #  \                              |
  def search_lots params  #\_____________________________/
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

    criteria = descentant_lots

    params.each do |cid, value|
      if value.is_a? Array
        criteria = criteria.in({"properties.characteristic_id" => [cid], 
                                            "properties.value" => value})
      else 
        match = cid.match(/(.+)_less_than$/)                                    # lte-+-fix
        unless match.nil?                                                       #     |
          criteria = criteria.where({"properties.characteristic_id" => match[1],#     V
                                         :properties.lte => {:value => value.to_f + 10**-10}}) if match.length > 1
        else
          match = cid.match(/(.+)_greater_than$/)
          unless match.nil?
            criteria = criteria.where({"properties.characteristic_id" => match[1], 
                                           :properties.gte => {:value => value}}) if match.length > 1
          else
            # do simple where
            criteria = criteria.where({"properties.characteristic_id" => cid, 
                                                   "properties.value" => value})
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
end
