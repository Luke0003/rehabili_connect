class CreateClientRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :client_records do |t|
      t.integer :client_id, null: false
      t.integer :condition, null: false
      t.string :comment
      t.date :record_date, null: false

      t.timestamps
    end
  end
end
