class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sold_day, :date
    add_reference :items, :user, foreign_key: true, null: false
    add_reference :items, :category, null: false, foreign_key: true
    add_reference :items, :item_size, foreign_key: true
  end
end
