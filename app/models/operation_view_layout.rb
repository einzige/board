class OperationViewLayout < Layout
  embedded_in :operation, :inverse_of => :view_layout
end
