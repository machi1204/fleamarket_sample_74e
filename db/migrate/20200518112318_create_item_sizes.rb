class CreateItemSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_sizes do |t|
      t.string      :ancestry
      t.string      :size, null: false
      t.timestamps
    end
  end
end
