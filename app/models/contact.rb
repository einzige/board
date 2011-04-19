class Contact
  include Mongoid::Document

  field :name
  field :phone
  field :email

  validates_presence_of :name, :email

  embedded_in :lot, :inverse_of => :contacts
end
