# -*- coding: utf-8 -*-
class ViewLayoutsController < LayoutsController
  @@layout_type = 'view'

  before_filter :except => :update do
    @operation = Operation.find_by_slug(params[:operation])
  end
end
