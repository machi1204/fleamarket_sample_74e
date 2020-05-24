class OrdersController < ApplicationController
  require 'payjp'

  def index
    @item = Item.find(params[:item_id])
#    @image = Image.find(params[:item_id]).first
    @image = Image.where(item_id: @item).first
    @category = Category.find(@item.category_id)
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    @item = Item.find(params[:item_id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => card.customer_id,
    :currency => 'jpy', 
  )
    @item.update(sold_day: Time.current)

  redirect_to action: 'done' 
  end
end
