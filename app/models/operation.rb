class Operation
  include Mongoid::Document
  include Mongoid::Slug

  field :name
  slug  :name

  referenced_in :category
  references_and_referenced_in_many :lots
  references_many :characteristics

  validates_presence_of :name
  validates_presence_of :category

  def self.for category
    Operation.any_in(:category_id => category.ancestors.only(:id).map(&:id) \
                                  << category.id)
  end
end
