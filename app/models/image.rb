class Image < ApplicationRecord
  belongs_to :item, optional: true

  mount_uploader :image, ImageUploader
  validates :image, presence: {message: "を１枚以上選択してください"}
end
