# -*- coding: utf-8 -*-
class Characteristic
  include Mongoid::Document
  include Mongoid::Slug
  field :name
  slug  :name
  #field :measure
  field :description
  field :required,    :type => Boolean, :default => false
  field :primary,     :type => Boolean, :default => false
  field :lots_count,  :type => Integer, :default => 0
  #field :collapsible, :type => Boolean, :default => false
  
  referenced_in :category
  referenced_in :operation

  embeds_one    :filter_layout, :class_name => 'CharacteristicFilterLayout'
  embeds_one    :view_layout,   :class_name => 'CharacteristicViewLayout'
  embeds_one    :form_layout,   :class_name => 'CharacteristicFormLayout'
  before_create do
    self.filter_layout ||= FilterLayout.new
    self.view_layout   ||= ViewLayout.new
    self.form_layout   ||= FormLayout.new
  end

  validates_presence_of     :name 
  validates_presence_of     :category
  validates_numericality_of :lots_count

  scope :boolean,   where(:_type => "BooleanCharacteristic")
  scope :integer,   where(:_type => "IntegerCharacteristic")
  scope :float,     where(:_type => "FloatCharacteristic")
  scope :string,    where(:_type => "StringCharacteristic")
  scope :selection, where(:_type => "SelectionCharacteristic")

  scope :shared,  where(:operation_id => nil)
  scope :for_operation, lambda {|operation| where(:operation_id => operation.id)}

  def inc_lots_count; inc(:lots_count, 1) end
  def dec_lots_count; inc(:lots_count,-1) end

  class << self
    alias find_by_slug! find_by_slug 
  end
end
