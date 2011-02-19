class Property
  include Mongoid::Document
  field :name
  field :required, :type => Boolean, :default => false
  field :primary,  :type => Boolean, :default => false
  field :ord,      :type => Integer, :default => 0
  
  validates_presence_of :name 
end
