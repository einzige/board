# -*- coding: utf-8 -*-
class FormLayoutsController < LayoutsController
  @@layout_type = 'form'

  before_filter :except => :update do
    operations = Operation.for(@category)
    @operation = operations.find_by_slug(params[:operation])
  end
end
