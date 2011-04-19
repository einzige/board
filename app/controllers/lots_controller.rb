# FIXME: security
class LotsController < ApplicationController

  def show
    @lot = Lot.find_by_slug(params[:id])
    unless @lot
      # FIXME
      if @category = Category.find_by_slug(params[:category_id])
        redirect_to category_path(@category)
      else
        redirect_to root_path
      end
    end
  end

  def new
    @category = Category.find_by_slug(params[:category_id])
    @lot = Lot.new(:category => @category)
  end

  def create # FIXME !!!
    @category = Category.find_by_slug(params[:category_id])

    @lot = @category.lots.new(params['lot'])

    @lot.user = current_user

    @lot.operations << Operation.any_in(:_id => params[:operation_ids])

    @lot.set_properties(params[:properties])

    photos = Photo.all(:conditions => {:session_token => params[:session_token]})

    if @lot.save
      @lot.attach_photos photos
      flash[:notice] = 'That\'s ok'
      redirect_to category_lot_path(@category, @lot)
    else
      render :text => params[:authenticity_token].to_s + " _____________ " + Photo.last.auth_token #@lot.errors.full_messages.inspect
    end
  end

  def destroy
    @lot = Lot.find_by_slug(params[:id])
    @lot.destroy

    redirect_to :back
  end

end
