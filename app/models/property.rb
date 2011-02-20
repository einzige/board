# This class describes lot property value
class Property
  include Mongoid::Document

  referenced_in :characteristic
  key           :characteristic_id

  # FIXME: what if we changed category for the given lot?
  def characteristic
    @__characteristic ||= lot.category.characteristics.criteria.id(characteristic_id).first
  end

  embedded_in :lot, :inverse_of => :properties

# validates_presence_of :characteristic_id # REMOVEME
  validates_presence_of :characteristic
  validates_presence_of :value, :if => :required?

  def required?; characteristic.required? 
  end

  scope :boolean, where(:_type => "BooleanProperty")
  scope :integer, where(:_type => "IntegerProperty")
  scope :float,   where(:_type => "FloatProperty")
  scope :string,  where(:_type => "StringProperty")

  after_create  :increase_characteristic_lots_count
  after_destroy :decrease_characteristic_lots_count

  protected
    def increase_characteristic_lots_count
      characteristic.update_attribute(:lots_count, characteristic.lots_count + 1)
    end
    def increase_characteristic_lots_count
      characteristic.update_attribute(:lots_count, characteristic.lots_count - 1)
    end
end
