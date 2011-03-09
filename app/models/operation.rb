class Operation
  include Mongoid::Document
  include Mongoid::Slug

  field :name
  slug  :name
  field :description

  referenced_in :category
  references_and_referenced_in_many :lots
  references_many :characteristics

  embeds_one :filter_layout, :class_name => 'OperationFilterLayout'
  embeds_one :view_layout,   :class_name => 'OperationViewLayout'
  embeds_one :form_layout,   :class_name => 'OperationFormLayout'
  before_create do
    self.filter_layout ||= OperationFilterLayout.new
    self.view_layout   ||= OperationViewLayout.new
    self.form_layout   ||= OperationFormLayout.new
  end

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
