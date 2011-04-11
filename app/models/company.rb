class Company
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps

  field :name

  references_many :goods
end
