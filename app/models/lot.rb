class Lot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name
  slug  :name
  field :description
  field :serial_number
  
  referenced_in                     :user
  referenced_in                     :category
  referenced_in                     :company
  references_and_referenced_in_many :operations
  references_many                   :photos, :dependent => :destroy
  embeds_many                       :properties
  embeds_one                        :contacts

  validates_presence_of :name
  validates_presence_of :category
  validates_length_of   :operation_ids, :minimum => 1
  validates_length_of   :name, :minimum => 2, :maximum => 512
  validates_length_of   :description, :maximum => 6000

  default_scope desc(:created_at)

  before_create  :set_serial_number
  after_create   :increase_category_lots_count
  before_destroy :clean_operations
  after_save     :save_operations, :save_properties
  after_destroy  :decrease_category_lots_count

  def get_property pname
    properties.find(:first, :conditions => {:slug => pname.to_s})
  end

  def has_property? pname
    !get_property(pname).nil?
  end

  def set_properties hash
    hash.each do |slug, v|
      next if v.strip.empty? # FIXME : removeme
      
      c = Characteristic.find_by_slug(slug) or next
      case c.class
      when IntegerCharacteristic then
        properties.build({:value => v.to_i,    :characteristic_id => c.id}, IntegerProperty)
      when FloatCharacteristic   then
        properties.build({:value => v.to_f,    :characteristic_id => c.id}, FloatProperty)
      when BooleanCharacteristic then
        properties.build({:value => v.to_bool, :characteristic_id => c.id}, BooleanProperty) # FIXME are we really need to_bool?
      else
        properties.build({:value => v,         :characteristic_id => c.id}, StringProperty)
      end
    end
  end

  def attach_photos attaching_photos, auto_save = true
    self.photos |= attaching_photos
    self.save if auto_save
  end

  def has_company?
    not company_id.nil?
  end

  def main_photo ptype = :medium
    photos.first.cover_picture.url ptype
  end

  def thumb
    main_photo :thumb
  end

  def has_photos?
    photos && photos.any?
  end

  protected
    def set_serial_number
      self.serial_number = ((Lot.max(:serial_number) || 0) + 1).to_i
    end
    def increase_category_lots_count
      category.inc(:lots_count, 1)
    end
    def decrease_category_lots_count
      category.inc(:lots_count, -1) unless category.nil?
    end

    def save_operations
      operations.each { |o| o.save if o.changed? }
    end
    def save_properties
      properties.each { |p| p.save if p.changed? }
    end
    def clean_operations
      operations.each { |o| o.lot_ids.delete(id) }
    end
end
