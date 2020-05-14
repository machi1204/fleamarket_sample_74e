class ItemsController < ApplicationController

  def index
    @items = Item.where(sold_day: nil).includes(:images).order(updated_at: "DESC")
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  def show
    @id = params[:id]
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).premit(:name, :price, :explanation, :condition, :shipping_fee, :shipping_day)
  end
  
end