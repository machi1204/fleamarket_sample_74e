class Address < ApplicationRecord
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :post_number, :prefecture_id, :city, :address, presence: true

  # ハイフン無しの７桁
  VALID_POST_NUMBER_REGEX = /\A\d{7}\z/
  validates :post_number,
    format: { with: VALID_POST_NUMBER_REGEX, message: "は'-'を含めない７桁で入力してください" }
end
