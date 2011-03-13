class CharacteristicContainersController < ApplicationController
  load_and_authorize_resource :find_by => :slug, :except => :create #FIXME!!!WARNING!! ERROR!

  before_filter :only => [:create, :update] do #FIXME
    operation = params[:characteristic_container][:operation]
    if operation.nil? || operation.empty?
      params[:characteristic_container][:operation_id] = nil
      params[:characteristic_container][:operation] = nil
    end
  end

  before_filter :except => :destroy do
    @category = Category.find_by_slug(params[:category_id])
  end

  def index
    @characteristic_containers = @category.characteristic_containers
  end

  def create
    @characteristic_container = @category.characteristic_containers.build(params[:characteristic_container])

    if @characteristic_container.save
      flash[:notice] = 'CharacteristicContainer was successfully created.'
      redirect_to [:edit, @category, @characteristic_container]
    else
      render :action => "new"
    end
  end

  def edit
    @characteristic_container = @category.characteristic_containers.find_by_slug(params[:id])
  end

  def update
    @characteristic_container = @category.characteristic_containers.find_by_slug(params[:id])
  
    if @characteristic_container.update_attributes(params[:characteristic_container])
      flash[:notice] = 'CharacteristicContainer was successfully updated.'
      redirect_to [:edit, @category, @characteristic_container]
    else
      render :action => "edit" 
    end
  end

  def new
    @characteristic_container = @category.characteristic_containers.build
  end

  def destroy
    @characteristic_container = CharacteristicContainer.find_by_slug(params[:id])
    @characteristic_container.destroy
    flash[:notice] = 'CharacteristicContainer successfully destroyed'

    redirect_to :back
  end
end
