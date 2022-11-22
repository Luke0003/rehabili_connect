class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :client_id, null: false
      t.integer :therapist_id, null: false
      t.integer :chat_id, null: false
      t.boolean :checked_client, null: false, default: false
      t.boolean :checked_therapist, null: false, default: false

      t.timestamps
    end
  end
end
