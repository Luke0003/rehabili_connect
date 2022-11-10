class CreateClientMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :client_menus do |t|
      t.integer :client_id, null: false
      t.integer :menu_id, null: false
      t.integer :client_record_id  # nullを許可
      t.date :start_time, null: false # カレンダーのカラム名に合わせた
      t.boolean :is_completed, null: false, default: false

      t.timestamps
    end
  end
end
