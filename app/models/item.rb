class Item < ApplicationRecord
  has_many :images
  has_many :users
  has_many :comments
end
