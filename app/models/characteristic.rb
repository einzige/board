# -*- coding: utf-8 -*-
class Characteristic
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Layout::Item

  default_layout

  field :name
  slug  :name
  #field :measure
  field :description
  field :required,    :type => Boolean, :default => false
  field :primary,     :type => Boolean, :default => false
  field :lots_count,  :type => Integer, :default => 0
  #field :collapsible, :type => Boolean, :default => false
  
  def required?; required end
  def primary?;  primary  end
  
  referenced_in :category
  referenced_in :operation
  referenced_in :characteristic_container

  validates_presence_of     :name 
  validates_numericality_of :lots_count
  #validates_presence_of    :category
  
  scope :without_container, where(:container_id => nil)

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
