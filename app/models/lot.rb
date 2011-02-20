class Lot
  include Mongoid::Document
  characteristic :name
  characteristic :description
  
  referenced_in :user
  referenced_in :category

  embeds_many :properties

  validates_presence_of :name
end
