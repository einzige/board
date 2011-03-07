class Contact
  include Mongoid::Document

  field :name
  field :phone
  field :email

  embedded_in :lot, :inverse_of => :contact
end
