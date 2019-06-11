class ProductsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def item_var_recommendations
    item = Item.find(recommendation_params[:item_id])
    size = Size.find_by(name: recommendation_params[:size])
    item_variation = ItemVariation.find_by(size: size, item_id: item.id)
    respond_to do |format|
      format.json { render json: item_variation.recommend_items.map { |ri| [ri.product, ri.size] } }
    end
  end

  private

  def recommendation_params
    params.permit(
      :size,
      :item_id
    )
  end
end
