class StringCharacteristic < Characteristic
  field :chars_limit, :type => Integer, :default => 512
  field :default, :type => String, :default => ''
end
