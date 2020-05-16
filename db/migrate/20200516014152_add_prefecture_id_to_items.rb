class AddPrefectureIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :prefecture_id, :integer, null: false
    add_column :items, :sold_day, :date
  end
end
