class LotsController < ApplicationController

  def new
    @category = Category.find_by_slug(params[:category_id])
    @lot = Lot.new(:category => @category)
  end

end
