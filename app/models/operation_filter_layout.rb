class OperationFilterLayout < Layout
  field :time_range_x, :type => Integer, :default => 0
  field :time_range_y, :type => Integer, :default => 0

  embedded_in :operation, :inverse_of => :filter_layout
end
