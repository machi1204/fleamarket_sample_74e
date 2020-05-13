class AddColumnItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sold_day, :date
  end
end
