class CreateCategorySizes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sizes do |t|
      t.references  :category,  index: true, foreign_key: true
      t.references  :item_size, index: true, foreign_key: true
      t.timestamps
    end
  end
end
