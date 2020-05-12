class Item < ApplicationRecord
  validates :name, presence: true
  validates :explanation, presence: true
  validates :shipping_fee, presence: true
  validates :shipping_day, presence: true
  validates :price, presence: true

  has_many :images

  accepts_nested_attributes_for :images, allow_destroy: true
end
