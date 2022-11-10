class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :client_id, null: false
      t.integer :therapist_id, null: false

      t.timestamps
    end
  end
end
