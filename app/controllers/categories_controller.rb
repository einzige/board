# -*- coding: utf-8 -*-
class CategoriesController < ApplicationController

  load_and_authorize_resource :only => [:edit, :create, :update, :destroy], :find_by => :slug

  def index
    @categories = {}
    @categories[:roots] = Category.roots.only(:slug, :name)
    @categories[:popular] = Category.where(:parent_id.in => @categories[:roots].only(:_id).map(&:_id)) \
                                    .desc(:lots_count)
                                    .limit(8)
                                    .only(:slug, :name, :parent_id)
    @lots = {}
    @lots[:urgent] = []#Lot.where(:bonus.matches => {:name => "urgent"})
    @lots[:recent] = Lot.desc(:created_at).limit(9)
  end

  def show
    @query = params[:q] || {}
    @category = Category.find_by_slug(params[:id])

    operations = @category.ancestors_operations
    @operation = operations.find_by_slug(params[:operation]) || operations.first

    @lots = @category.search_lots(@query, @operation) 
                     .where(:created_at.gt => (-((params[:time_range] || NumericCharacteristic::GROSS).to_i)).days.from_now)
  end

  def edit
    @category = Category.find_by_slug(params[:id])

    operations = @category.ancestors_operations
    @operation = operations.find_by_slug(params[:operation]) || operations.first
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

  # AJAX
  def children
    category = Category.criteria.id(params[:id]).first

    resp = category.children.map do |c|
      { :id     =>  c.id, 
        :branch => !c.leaf?, 
        :name   =>  c.name, 
        :slug   =>  c.slug }
    end

    respond_to do |wants|
      wants.js { render :json => resp }
    end
  end
end
