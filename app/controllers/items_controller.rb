class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

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

  # 孫カテゴリーが選択された後に動くアクション
  def get_size
    selected_grandchild = Category.find("#{params[:grandchild_id]}")
    selected_child = selected_grandchild.parent
    if related_size_parent = selected_child.item_sizes[0]
      @sizes = related_size_parent.children
    else
      selected_child = Category.find("#{params[:grandchild_id]}").parent
      if related_size_parent = selected_child.item_sizes[0]
        @sizes = related_size_parent.children
      end
    end
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
    if @item.destroy
      redirect_to user_path
    else
      redirect_to item_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :category_id, :item_size_id, :price, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

end
