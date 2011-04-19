# This class describes lot property value
class Property
  include Mongoid::Document

  field :slug
  referenced_in :characteristic

  embedded_in :lot, :inverse_of => :properties

  validates_presence_of :characteristic

  def required?; #FIXME
    characteristic_id.nil? || characteristic.required? 
  end

  scope :boolean, where(:_type => "BooleanProperty")
  scope :integer, where(:_type => "IntegerProperty")
  scope :float,   where(:_type => "FloatProperty")
  scope :string,  where(:_type => "StringProperty")

  after_create  :increase_characteristic_lots_count
  after_destroy :decrease_characteristic_lots_count
  before_save   :connect_to_characteristic # FIXME

  protected
    def connect_to_characteristic
      self['slug'] = characteristic.slug
    end
    def increase_characteristic_lots_count
      characteristic.inc_lots_count
    end
    def decrease_characteristic_lots_count
      characteristic.dec_lots_count unless characteristic.nil?
    end
end
