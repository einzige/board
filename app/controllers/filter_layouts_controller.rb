# -*- coding: utf-8 -*-
class FilterLayoutsController < LayoutsController
  @@layout_type = 'filter'

  before_filter :except => :update do
    @operation = Operation.find_by_slug(params[:operation]) || @category.ancestors_operations.first
  end
end
