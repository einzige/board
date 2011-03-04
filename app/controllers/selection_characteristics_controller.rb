class SelectionCharacteristicsController < CharacteristicsController
  @@characteristic_class = SelectionCharacteristic

  def set_collections
    @characteristic.selection_collection_ids = []
    @characteristic.save

    if params[:collections]
      @characteristic.selection_collections = SelectionCollection.any_in(:_id => params[:collections])
      @characteristic.save
    end

    redirect_to :back
  end
end
