# -*- coding: utf-8 -*-
class FilterLayoutsController < LayoutsController
  @@layout_type = 'filter'

  before_filter :except => :update do
    operations = Operation.for(@category)
    @operation = operations.find_by_slug(params[:operation]) || operations.first
  end
end
