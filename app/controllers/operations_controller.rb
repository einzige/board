class OperationsController < ApplicationController
  load_and_authorize_resource :except => :show, :find_by => :slug

  before_filter :except => :destroy do
    @category = Category.find_by_slug(params[:category_id])
  end

  def index
    @operations = @category.operations
  end

  def create
    @operation = @category.operations.build(params[:operation])

    if @operation.save
      flash[:notice] = 'Operation was successfully created.'
      redirect_to [:edit, @category, @operation]
    else
      render :action => "new"
    end
  end

  def edit
    @operation = @category.operations.find_by_slug(params[:id])
  end

  def update
    @operation = @category.operations.find_by_slug(params[:id])
  
    if @operation.update_attributes(params[:operation])
      flash[:notice] = 'Operaion was successfully updated.'
      redirect_to [:edit, @category, @operation]
    else
      render :action => "edit" 
    end
  end

  def new
    @operation = @category.operations.build
  end

  def destroy
    @operation = Operation.find_by_slug(params[:id])
    @operation.destroy
    flash[:notice] = 'Operation successfully destroyed'

    redirect_to :back
  end
end
