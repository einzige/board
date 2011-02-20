class Property
  include Mongoid::Document
  field :name
  field :required, :type => Boolean, :default => false
  field :primary,  :type => Boolean, :default => false
  field :ord,      :type => Integer, :default => 0

  embedded_in :category, :inverse_of => :properties
  
  validates_presence_of   :name 
  validates_uniqueness_of :name

  scope :boolean, where(:_type => "BooleanProperty")
  scope :integer, where(:_type => "IntegerProperty")
  scope :float,   where(:_type => "FloatProperty")
  scope :string,  where(:_type => "StringProperty")
end
