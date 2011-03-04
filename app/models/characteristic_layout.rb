class CharacteristicLayout
  include Mongoid::Document

  embedded_in :characteristic, :inverse_of => :layout

  field :x,       :type => Integer, :default => 0
  field :y,       :type => Integer, :default => 0
  field :padding, :type => Integer, :default => 0
  field :width,   :type => Integer, :default => 100
  field :height,  :type => Integer, :default => 20
end
