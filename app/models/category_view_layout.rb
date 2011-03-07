class CategoryViewLayout < Layout
  embedded_in :category, :inverse_of => :view_layout
end
