class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

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
      redirect_to root_path, notice: '商品を出品しました'
    else
      flash.now[:notice] = '出品には必須項目が必要です'
      render :new
    end
  end

  def show
    @order = Item.find(params[:id])
  end

  def edit
    grandchild_category = @item.category
    child_category = grandchild_category.parent
    # 親カテゴリを取得
    @category_parent_array = Category.where(ancestry: nil)
    # 子カテゴリを取得
    @category_children_array = Category.where(ancestry: child_category.ancestry)
    # 孫カテゴリを取得
    @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)

    #サイズがある場合、サイズカテゴリを取得
    if @item.item_size_id != nil
      @item_size_array = @item.item_size.siblings
    end
  end

  def update
    if params[:item][:item_size_id] != nil
      item_update(item_params)
    else
      item_update(update_params)
    end
  end

  def destroy
    if @item.destroy
      redirect_to user_path
    else
      redirect_to item_path
    end
  end

  def set_images
    @images = Image.where(item_id: params[:id])
  end
  
  private
  def item_update(parameter)
    if @item.update(parameter)
      redirect_to root_path, notice: '商品を編集しました'
    else
      redirect_to edit_item_path(@item), notice: '必須項目を入力してください'
    end
  end

  def item_params
    params.require(:item).permit(:name, :category_id, :item_size_id, :price, :brand, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
      images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :explanation, :condition_id, :shipping_fee_id, :shipping_day_id, :prefecture_id, :brand, :price, :category_id,
      images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id, item_size_id: "")
  end

  
  def set_item
    @item = Item.find(params[:id])
  end

end

