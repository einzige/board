# This class describes lot property value
class Property
  include Mongoid::Document

  referenced_in :characteristic
  key           :characteristic_id

  # FIXME: what if we changed category for the given lot?
=begin
  def characteristic
    @__characteristic ||= lot.category.characteristics.criteria.id(characteristic_id).first 
  end
=end
  def ch
    @__characteristic ||= lot.category.characteristics.criteria.id(characteristic_id).first 
  end

  embedded_in :lot, :inverse_of => :properties

# validates_presence_of :characteristic_id # REMOVEME
  validates_presence_of :characteristic_id
  validates_presence_of :value, :if => :required?

  def required?; 
    characteristic_id.nil? || characteristic.required? 
  end

  scope :boolean, where(:_type => "BooleanProperty")
  scope :integer, where(:_type => "IntegerProperty")
  scope :float,   where(:_type => "FloatProperty")
  scope :string,  where(:_type => "StringProperty")

  after_create  :increase_characteristic_lots_count
  after_destroy :decrease_characteristic_lots_count

  protected
    def increase_characteristic_lots_count
      characteristic.inc_lots_count
    end
    def decrease_characteristic_lots_count
      characteristic.dec_lots_count 
    end
end
