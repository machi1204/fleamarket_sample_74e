class ChangeDataPrefectureIdToAddresses < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :prefecture_id, :integer
  end
end
