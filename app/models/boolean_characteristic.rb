class BooleanCharacteristic < Characteristic
  field :default, :type => Boolean 
end

# FIXME: remove below
#
class Fixnum
  public
  def to_bool; !zero? end
end

class String
  public
  def to_bool; !to_i.zero? end
end
