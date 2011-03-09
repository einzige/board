class Layout 
  include Mongoid::Document
  field :width,  :type => Integer, :default => 600
  field :height, :type => Integer, :default => 100
end
