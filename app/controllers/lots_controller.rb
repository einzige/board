class LotsController < ApplicationController

  def new
    @category = Category.find_by_slug(params[:category_id])
    @lot = Lot.new(:category => @category)
  end

  def create
    @category = Category.find_by_slug(params[:category_id])
    @lot = @category.lots.new(params['lot'])
    @lot.operations << Operation.any_in(:_id => params[:operation_ids])

    if @lot.save
      flash[:notice] = 'zaibis'
      redirect_to :back
    else
      render :text => @lot.errors.full_messages.inspect
    end
  end

end
