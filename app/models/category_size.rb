class CategorySize < ApplicationRecord
  belongs_to :category
  belongs_to :item_size
end
