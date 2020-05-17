class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    @items = Item.where(sold_day: nil).includes(:images).order(updated_at: "DESC")
  end

  def new
    @item = Item.new
    @item.images.new
  end

  # 親カテゴリーが選択された後に動くアクション
  def category_children
    #親カテゴリーに紐付く子カテゴリーを取得
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  # 子カテゴリーが選択された後に動くアクション
  def category_grandchildren
    #子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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
  end

  private
  def item_params
    params.require(:item).permit(:name, :category_id, :price, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
     images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

end
