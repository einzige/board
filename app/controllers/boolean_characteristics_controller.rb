class BooleanCharacteristicsController < CharacteristicsController
  @@characteristic_class = BooleanCharacteristic

  before_filter :only => :update do
    default = params[:characteristic][:default] 
    if default.nil? || default.empty?
      params[:characteristic][:default] = nil
    end
  end
end
