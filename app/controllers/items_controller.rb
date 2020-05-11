class ItemsController < ApplicationController
  
  def index
  end

  def new
    @item = Item.new
  end

  def create
    if Item.create(item_params)
      redirect_to root_path
    end
  end

  def show
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :explanation, :condition, :shipping_fee, :shipping_day)
  end  
end
