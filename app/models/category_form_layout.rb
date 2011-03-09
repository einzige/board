class CategoryFormLayout < Layout
  embedded_in :category, :inverse_of => :form_layout
end
