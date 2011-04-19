class Company
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :name
  validates_presence_of :name

  references_many :goods
end
