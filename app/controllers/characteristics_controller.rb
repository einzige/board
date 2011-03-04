# -*- coding: utf-8 -*-
class CharacteristicsController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  @@characteristic_class = nil
  def self.characteristic_class
    @@characteristic_class
  end

  before_filter :authenticate_user!

  before_filter :except => :index do
    if !self.class.characteristic_class 
      raise "Characteristic class must be set on this controller"
    end
  end

  before_filter :only => [:create, :update] do #FIXME
    if params['characteristic']['operation'].empty?
      params['characteristic']['operation'] = nil 
    end
  end

  before_filter do
    @category = Category.find_by_slug(params[:category_id])
  end

  before_filter :except => [:new, :create, :index] do
    @characteristic = Characteristic.find_by_slug(params[:id])
  end

  before_filter :only => :update do
    operation = params[:characteristic][:operation]
    if operation.nil? || operation.empty?
      params[:characteristic][:operation_id] = nil
    end
  end

  def index
    @characteristics = @category.characteristics
    render 'characteristics/index'
  end

  def edit
  end

  def show
    render :action => :edit
  end

  def new 
    @characteristic = @category.characteristics.build({}, self.class.characteristic_class)
  end

  def create
    @characteristic = @category.characteristics.build(params[:characteristic], self.class.characteristic_class)

    if @characteristic.save
      flash[:notice] = 'Характеристика добавлена'
      redirect_to [@category, @characteristic]
    else
      render :action => :new
    end
  end

  def update
    if @characteristic.update_attributes(params[:characteristic])
      flash[:notice] = 'Characteristic was successfully updated.'
      redirect_to [@category, @characteristic]
    else
      render :action => :edit
    end
  end

  def destroy
    @characteristic.destroy
    flash[:notice] = 'Характеристика успешно удалена'
  
    redirect_to [@category, :characteristics]
  end

end
