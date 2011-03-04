# _*_ coding: utf-8 _*_ 
class SelectionCharacteristicOptionsController < ApplicationController

  load_and_authorize_resource :find_by => :slug

  before_filter do
    @category = Category.find_by_slug(params[:category_id])
    @characteristic = @category.characteristics.find_by_slug(params[:selection_characteristic_id])
  end

  def index
    @selection_options = @characteristic.selection_options
  end

  def new
    @selection_option = @characteristic.selection_options.build
  end

  def edit
    @selection_option = @characteristic.selection_options.find_by_slug(params[:id])
  end

  def update
    @selection_option = @characteristic.selection_options.find_by_slug(params[:id])
    if @selection_option.update_attributes(params[:selection_option])
      flash[:notice] = 'Опция успешно обновлена'
      redirect_to [:edit, @category, @characteristic, @selection_option]
    else
      render :action => 'edit'
    end
  end

  def create
    @selection_option = @characteristic.selection_options.build(params[:selection_option])

    if @selection_option.save
      flash[:notice] = 'Опция успешно создана'
      redirect_to [:edit, @category, @characteristic, @selection_option]
    else
      render :action => 'new'
    end
  end

  def destroy
    @selection_option = @characteristic.selection_options.find_by_slug(params[:id])

    @selection_option.destroy
    flash[:notice] = 'Опция успешно удалена'

    redirect_to :back
  end
end
