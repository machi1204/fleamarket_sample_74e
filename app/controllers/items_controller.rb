class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

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
  end

  def edit
  end

  def update
    imageLength = 0
    deleteImage = 0
    params[:item][:images_attributes].each do |p|
      imageLength += 1
    end
    for num in 0..9
      if params[:item][:images_attributes][num.to_s] != nil
        if params[:item][:images_attributes][num.to_s][:_destroy] == "1"
          deleteImage += 1
        end
      end
    end
    if @item.valid? && !@item.images.empty? && imageLength != deleteImage
      @item.update(item_params)
      redirect_to root_path, notice: '出品した商品を編集しました'
    else
      flash.now[:notice] = '必須項目を入力してください'
      @item.images.build
      render :edit
    end
  end

  def set_images
    @images = Image.where(item_id: params[:id])
  end


  private
  def item_params
    params.require(:item).permit(:name, :price, :brand, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
     images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

end
