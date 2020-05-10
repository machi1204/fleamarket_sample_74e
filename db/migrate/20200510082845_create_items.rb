class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string :explanation, null: false
      t.string :condition, null: false
      t.string :shipping_fee, null: false
      t.string :shipping_day, null: false

      t.timestamps
    end
  end
end
