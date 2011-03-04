class CategoryLayout 
  include Mongoid::Document
  field :height,       :type => Integer, :default => 100
  field :time_range_x, :type => Integer, :default => 0
  field :time_range_y, :type => Integer, :default => 0

  embedded_in :category, :inverse_of => :layout
end
