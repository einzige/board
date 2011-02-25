class CategoriesController < ApplicationController

  def index
    @categories = {}
    @categories[:roots] = Category.roots.only(:slug, :name)
    @categories[:popular] = Category.where(:parent_id.in => Category.roots.only(:id).map(&:id)) \
                                    .desc(:lots_count)
                                    .limit(8)
                                    .only(:slug, :name, :parent_id)
    @lots = {}
    @lots[:urgent] = []#Lot.where(:bonus.matches => {:name => "urgent"})
    @lots[:recent] = Lot.desc(:created_at).limit(9)
  end

  def show
    @q = params[:q] || {}
    @category = Category.find_by_slug(params[:id])

    operations = Operation.for(@category)
    @operation = operations.find_by_slug(params[:operation]) || operations.first

    @lots = @category.search_lots(@q, @operation)
  end

end
