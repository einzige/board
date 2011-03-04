# -*- coding: utf-8 -*-
class CategoriesController < ApplicationController

  load_and_authorize_resource :except => [:show, :index], :find_by => :slug

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

  def create
    @category = Category.new(params[:category])
  
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to [:edit, @category]
    else
      render :action => "new"
    end
  end

  def destroy
    @category = Category.find_by_slug(params[:id])
    @category.destroy
  
    redirect_to :back
  end

  def set_layout
    category = Category.find_by_slug(params[:id])
    category.update_attribute(:layout, params[:layout])
    
    if params[:characteristics]
      params[:characteristics].each do |cid, location|
        Characteristic.criteria.id(cid).first.update_attribute(:layout, location[:layout])
      end
    end
    flash[:notice] = 'Раскладка успешно сохранена.'
    redirect_to :back
  end

end
