class ItemsController < ApplicationController
  
  def index
  end

  def new
    @item = Item.new
    @item.images.new
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
    params.require(:item).permit(:name, :price, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :user_id,
     images_attributes: [:image, :_destroy, :id])
  end  
end
