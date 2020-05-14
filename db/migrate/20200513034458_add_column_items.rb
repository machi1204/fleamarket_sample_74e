class AddColumnItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sold_day, :date
    add_reference :items, :user, foreign_key: true, null: false
  end
end
