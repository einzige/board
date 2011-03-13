# -*- coding: utf-8 -*-
class FormLayoutsController < LayoutsController
  @@layout_type = 'form'

  before_filter :except => :update do
    @operation = Operation.find_by_slug(params[:operation])
  end
end
