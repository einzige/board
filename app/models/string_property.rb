class StringProperty < Property
  field :chars_limit, :type => Integer, :default => 512

  embedded_in :category, :inverse_of => :string_properties
end
