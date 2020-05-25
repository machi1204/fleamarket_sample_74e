# it "商品名がなければ無効であること" do
#   @item = Item.new(name: nil)
#   @item.valid?
#   expect(item.errors[:first_name]).to include("can't be blank")
# end