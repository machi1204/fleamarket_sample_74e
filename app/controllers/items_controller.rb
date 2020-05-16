class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Item.where(sold_day: nil).includes(:images).order(updated_at: "DESC")
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
    @id = params[:id]
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :user_id,
     images_attributes: [:image, :_destroy, :id])
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

end
