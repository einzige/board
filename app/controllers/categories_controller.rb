# -*- coding: utf-8 -*-
class CategoriesController < ApplicationController

  def index
    @categories = {}
    @categories[:roots] = Category.roots.only(:slug, :name)
    @categories[:popular] = Category.where(:parent_id.in => Category.roots.only(:id).map(&:id)) \
                                    .desc(:lots_count)
                                    .limit(8)
                                    .only(:slug, :name, :parent_id)
    @lots = {}
    @lots[:urgent] = []#Lot.where(:bonus.matches => {:name => "urgent"})
    @lots[:recent] = Lot.desc(:created_at).limit(9)
  end

  def show
    @q = params[:q] || {}
    @category = Category.find_by_slug(params[:id])

    operations = Operation.for(@category)
    @operation = operations.find_by_slug(params[:operation]) || operations.first

    @lots = @category.search_lots(@q, @operation) 
                     .where(:created_at.gt => (-((params[:time_range] || NumericCharacteristic::GROSS).to_i)).days.from_now)
  end

  def edit
    @category = Category.find_by_slug(params[:id])

    operations = Operation.for(@category)
    @operation = operations.find_by_slug(params[:operation]) || operations.first

    @characteristics = @category.characteristics_for(@operation)
  end

  def update
    @category = Category.find_by_slug(params[:id])
  
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Категория успешно сохранена.'
      redirect_to(edit_category_path(@category))
    else
      render :action => :edit
    end
  end

  def set_layout
    category = Category.find_by_slug(params[:id])
    category.update_attribute(:layout, params[:layout])
    
    params[:characteristics].each do |cid, location|
      Characteristic.criteria.id(cid).first.update_attribute(:layout, location[:layout])
    end
    flash[:notice] = 'Раскладка успешно сохранена.'
    redirect_to :back
  end

end
