class Item < ApplicationRecord
  validates :name, presence: true
  validates :explanation, presence: true
  validates :shipping_fee, presence: true
  validates :shipping_day, presence: true
  validates :price, presence: true
end
