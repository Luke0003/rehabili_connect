class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.integer :genre_id, null: false
      t.string :menu_name, null: false
      t.text :menu_content, null: false
      t.string :menu_purpose, null: false

      t.timestamps
    end
  end
end
