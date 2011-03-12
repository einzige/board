class ContainersController < ApplicationController
  load_and_authorize_resource :find_by => :slug

  before_filter :except => :destroy do
    @category = Category.find_by_slug(params[:category_id])
  end

  def index
    @containers = @category.containers
  end

  def create
    @container = @category.containers.build(params[:container])

    if @container.save
      flash[:notice] = 'Container was successfully created.'
      redirect_to [:edit, @category, @container]
    else
      render :action => "new"
    end
  end

  def edit
    @container = @category.containers.find_by_slug(params[:id])
  end

  def update
    @container = @category.containers.find_by_slug(params[:id])
  
    if @container.update_attributes(params[:container])
      flash[:notice] = 'Container was successfully updated.'
      redirect_to [:edit, @category, @container]
    else
      render :action => "edit" 
    end
  end

  def new
    @container = @category.containers.build
  end

  def destroy
    @container = Container.find_by_slug(params[:id])
    @container.destroy
    flash[:notice] = 'Container successfully destroyed'

    redirect_to :back
  end
end
