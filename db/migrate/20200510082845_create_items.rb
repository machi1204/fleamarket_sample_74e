class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.text :explanation, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :condition_id, null: false
      t.integer :shipping_fee_id, null: false
      t.integer :shipping_day_id, null: false
      t.timestamps
      
    end
  end
end
