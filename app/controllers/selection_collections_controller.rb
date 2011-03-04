# _*_ coding: utf-8 _*_
class SelectionCollectionsController < ApplicationController
  
  def create
    @collection = SelectionCollection.new(params[:selection_collection])
    if @collection.save
      flash[:notice] = 'Коллекция успешно добавлена'

      @collection.parse_items(params[:items])

      redirect_to :back
    else
      flash[:notice] = 'Введите имя!'
      redirect_to :back #FIXME // just in a dev mod
    end
  end

end
