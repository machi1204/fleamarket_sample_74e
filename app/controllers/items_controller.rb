class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

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
  end

  def edit
  end

  def destroy
    @item.destroy
    redirect_to user_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
     images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

end
