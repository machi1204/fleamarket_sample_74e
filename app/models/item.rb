class Item < ApplicationRecord
  validates :name, :explanation, :shipping_fee, :shipping_day, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0, less_than: 9999999 }

  has_many :images

  accepts_nested_attributes_for :images, allow_destroy: true
end
