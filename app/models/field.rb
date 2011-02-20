class Field
  include Mongoid::Document
  field :name
  field :required, :type => Boolean, :default => false
  field :primary,  :type => Boolean, :default => false
  field :ord,      :type => Integer, :default => 0

  embedded_in :category, :inverse_of => :fields
  
  validates_presence_of   :name 
  validates_uniqueness_of :name

  scope :boolean, where(:_type => "BooleanField")
  scope :integer, where(:_type => "IntegerField")
  scope :float,   where(:_type => "FloatField")
  scope :string,  where(:_type => "StringField")
end
