class Item < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :shipping_fee 
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture

  validates :name, :explanation, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 9999999 }
  validates_associated :images
  validates :images, presence: true
  accepts_nested_attributes_for :images, allow_destroy: true

  

end
