require 'rails_helper'

describe ItemsController, type: :controller do
  
  before(:each) do
    FactoryBot.create :user
  end

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it "ユーザーログイン、出品画像、商品名、価格、商品の説明、カテゴリー、商品の状態、発送料の負担、発送元の地域、発送までの日数" do
      user = create(:user)
      category = create(:category)
      item = FactoryBot.build(:item, :with_image, category_id: category[:id])
      expect(item).to be_valid
    end
  end

end