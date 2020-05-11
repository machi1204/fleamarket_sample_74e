class ItemsController < ApplicationController
  
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  end

  def show
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :explanation, :condition, :shipping_fee, :shipping_day)
  end  
end
