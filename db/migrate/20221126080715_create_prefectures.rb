class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :prefecture_name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
