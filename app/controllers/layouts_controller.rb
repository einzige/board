# -*- coding: utf-8 -*-
class LayoutsController < ApplicationController

  before_filter do
    redirect_to root_url unless current_user && current_user.admin?
  end

  AVIABLE_LAYOUTS = ['filter', 'view', 'form']

  @@layout_type = nil
  def self.layout_type
    @@layout_type
  end

  before_filter do
    if !self.class.layout_type || ! AVIABLE_LAYOUTS.include?(self.class.layout_type)
      raise "Layout type must be set on this controller in one of #{AVIABLE_LAYOUTS.to_s}"
    end
  end

  before_filter do
    @category = Category.find_by_slug(params[:category_id])
  end

  def edit
    if @operation
      @characteristics = @operation.ancestors_characteristics.without_container
    else
      @characteristics = @category.ancestors_characteristics.without_operation.without_container
    end
  end

  def update
    @category  = Category.find_by_slug(params[:category_id])
    @operation = Operation.find_by_slug(params[:operation])

    layout_name = self.class.layout_type + '_layout'
    (@operation || @category).update_attribute(layout_name, params[layout_name])
    
    if params[:characteristics]
      params[:characteristics].each do |cid, location|
        Characteristic.criteria.id(cid).first.update_attribute(layout_name, location[layout_name])
      end
    end
    if params[:characteristic_containers]
      params[:characteristic_containers].each do |cid, location|
        CharacteristicContainer.criteria.id(cid).first.update_attribute(layout_name, location[layout_name])
      end
    end
    flash[:notice] = 'Раскладка успешно сохранена.'
    redirect_to :back
  end
end
