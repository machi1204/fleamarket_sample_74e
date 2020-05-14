class Item < ApplicationRecord
  has_many :images

  belongs_to :category
end
