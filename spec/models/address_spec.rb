require 'rails_helper'

describe User do
  describe '#create' do
    # 1. post_number,prefecture_id,city,addressが存在すれば登録できること
    it "is valid with a post_number,refecture_id,city,address" do
      address = build(:address)
      expect(address).to be_valid
    end

    # 2. post_numberが空では登録できないこと
    it "is invalid without a post_number" do
      address = build(:address, post_number: nil)
      address.valid?
      expect(address.errors[:post_number]).to include("を入力してください")
    end

    # 3. prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    # 4. cityが空では登録できないこと
    it "is invalid without a city" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    # 5. addressが空では登録できないこと
    it "is invalid without a address" do
      address = build(:address, address: nil)
      address.valid?
      expect(address.errors[:address]).to include("を入力してください")
    end

    # 6. post_numberのフォーマットを検証
      it "Correct format" do
        user = build(:address, post_number: '123-4567')
        user.valid?
        expect(user.errors[:post_number]).to include("は'-'を含めない７桁で入力してください")
      end

  end
end